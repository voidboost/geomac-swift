import Alamofire
import Combine
import Foundation
import Gzip
import SwiftyXMLParser

struct GeomacRepository {
    private let session = Session(
        startRequestsImmediately: false,
        redirectHandler: .modify { task, request, _ in
            var newRequest = task.originalRequest ?? task.currentRequest ?? request
            newRequest.url = request.url

            return newRequest
        },
        eventMonitors: [CustomMonitor()]
    )

    func apple(mac: String) -> AnyPublisher<(Double, Double), Error> {
        session.request(GeomacService.apple(mac: mac))
            .publishData()
            .value()
            .tryMap { data in
                let index = {
                    var i = data.count

                    let bytes = [0x00, 0x00, 0x00, 0x01, 0x00, 0x00]

                    for d in 0..<data.count - bytes.count {
                        i = d

                        for b in 0..<bytes.count {
                            if data[d + b] != bytes[b] {
                                i = data.count
                                break
                            }
                        }

                        if i != data.count {
                            break
                        }
                    }

                    return i
                }()

                let response = try Apple_Response(serializedBytes: data.suffix(from: index + 8))

                guard response.wifis.count > 0,
                      response.wifis[0].location.hasLatitude,
                      response.wifis[0].location.hasLongitude,
                      response.wifis[0].location.latitude != -18000000000,
                      response.wifis[0].location.longitude != -18000000000
                else {
                    throw GeomacErrors.notFound
                }

                return (
                    Double(response.wifis[0].location.latitude) * pow(10, -8),
                    Double(response.wifis[0].location.longitude) * pow(10, -8)
                )
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func google(mac: String) -> AnyPublisher<(Double, Double), Error> {
        session.request(GeomacService.google(mac: mac))
            .publishData()
            .value()
            .tryMap { data in

                let index = {
                    var i = data.count

                    let bytes = [0x1f, 0x8b]

                    for d in 0..<data.count - bytes.count {
                        i = d

                        for b in 0..<bytes.count {
                            if data[d + b] != bytes[b] {
                                i = data.count
                                break
                            }
                        }

                        if i != data.count {
                            break
                        }
                    }

                    return i
                }()

                let gunzipped = try data.suffix(from: index).gunzipped()

                let response = try Google_Response(serializedBytes: gunzipped)

                guard response.data.wifis.count > 0,
                      let wifi = response.data.wifis.first(where: { $0.wifiData.location.hasLatitude && $0.wifiData.location.hasLongitude })
                else {
                    throw GeomacErrors.notFound
                }

                return (
                    Double(Int32(truncatingIfNeeded: wifi.wifiData.location.latitude)) * pow(10, -7),
                    Double(Int32(truncatingIfNeeded: wifi.wifiData.location.longitude)) * pow(10, -7)
                )
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func microsoft(mac: String) -> AnyPublisher<(Double, Double), Error> {
        session.request(GeomacService.microsoft(mac: mac))
            .publishString()
            .value()
            .tryMap { res in
                let xml = try XML.parse(res)

                guard let coordinates = xml.all?.find({ $0.attributes.keys.contains("Latitude") && $0.attributes.keys.contains("Longitude") }),
                      let lat = Double(coordinates.attributes["Latitude"] ?? ""),
                      let lon = Double(coordinates.attributes["Longitude"] ?? "")
                else {
                    throw GeomacErrors.notFound
                }

                return (lat, lon)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func yandex(mac: String) -> AnyPublisher<(Double, Double), Error> {
        session.request(GeomacService.yandex(mac: mac))
            .publishString()
            .value()
            .tryMap { res in
                let xml = try XML.parse(res)

                guard let coordinates = xml.all?.find({ $0.attributes.keys.contains("latitude") && $0.attributes.keys.contains("longitude") }),
                      let lat = Double(coordinates.attributes["latitude"] ?? ""),
                      let lon = Double(coordinates.attributes["longitude"] ?? "")
                else {
                    throw GeomacErrors.notFound
                }

                return (lat, lon)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func mylnikov(mac: String) -> AnyPublisher<(Double, Double), Error> {
        session.request(GeomacService.mylnikov(mac: mac))
            .publishData()
            .value()
            .tryMap { res in
                guard let json = try? JSONSerialization.jsonObject(with: res, options: .fragmentsAllowed) as? [String: Any],
                      let data = json["data"] as? [String: Any],
                      let lat = data["lat"] as? Double,
                      let lon = data["lon"] as? Double
                else {
                    throw GeomacErrors.notFound
                }

                return (lat, lon)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

final class CustomMonitor: EventMonitor {
    func request<Value>(_: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print(response.customDebugDescription)
    }
}

extension DataResponse {
    var customDebugDescription: String {
        guard let urlRequest = request else { return "[Request]: None\n[Result]: \(result)" }

        let requestDescription = DebugDescription.description(of: urlRequest)

        let responseDescription = response.map { response in
            let responseBodyDescription = DebugDescription.description(for: data, headers: response.headers)

            return """
            \(DebugDescription.description(of: response))
                \(responseBodyDescription.indentingNewlines())
            """
        } ?? "[Response]: None"

        let networkDuration = metrics.map { "\($0.taskInterval.duration.formatted(.number.grouping(.never).precision(.fractionLength(10))))s" } ?? "None"

        if case let .failure(error) = result {
            return """
            \(requestDescription)
            \(responseDescription)
            [Network Duration]: \(networkDuration)
            [Serialization Duration]: \(serializationDuration.formatted(.number.grouping(.never).precision(.fractionLength(10))))s
            [Error]: \(error.localizedDescription)
            """
        } else {
            return """
            \(requestDescription)
            \(responseDescription)
            [Network Duration]: \(networkDuration)
            [Serialization Duration]: \(serializationDuration.formatted(.number.grouping(.never).precision(.fractionLength(10))))s
            """
        }
    }
}

private enum DebugDescription {
    static func description(of request: URLRequest) -> String {
        let requestSummary = "\(request.httpMethod!) \(request)"
        let requestHeadersDescription = DebugDescription.description(for: request.headers)
        let requestBodyDescription = DebugDescription.description(for: request.httpBody, headers: request.headers)

        return """
        [Request]: \(requestSummary)
            \(requestHeadersDescription.indentingNewlines())
            \(requestBodyDescription.indentingNewlines())
        """
    }

    static func description(of response: HTTPURLResponse) -> String {
        """
        [Response]:
            [Status Code]: \(response.statusCode)
            \(DebugDescription.description(for: response.headers).indentingNewlines())
        """
    }

    static func description(for headers: HTTPHeaders) -> String {
        guard !headers.isEmpty else { return "[Headers]: None" }

        let headerDescription = "\(headers.sorted())".indentingNewlines()

        return """
        [Headers]:
            \(headerDescription)
        """
    }

    static func description(for data: Data?,
                            headers: HTTPHeaders,
                            allowingPrintableTypes printableTypes: [String] = ["json", "xml", "text", "x-www-form-urlencoded"]) -> String
    {
        guard let data, !data.isEmpty else { return "[Body]: None" }

        guard printableTypes.compactMap({ headers["Content-Type"]?.contains($0) }).contains(true)
        else {
            return "[Body]: \(data.count) bytes"
        }

        return """
        [Body]:
            \(String(decoding: data, as: UTF8.self)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .indentingNewlines())
        """
    }
}

private extension String {
    func indentingNewlines(by spaceCount: Int = 4) -> String {
        let spaces = String(repeating: " ", count: spaceCount)
        return replacingOccurrences(of: "\n", with: "\n\(spaces)")
    }
}
