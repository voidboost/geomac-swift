import Alamofire
import Foundation
import Gzip

enum GeomacService {
    case apple(mac: String)
    case google(mac: String)
    case microsoft(mac: String)
    case yandex(mac: String)
    case mylnikov(mac: String)
}

extension GeomacService: URLRequestConvertible {
    var baseURL: URL {
        switch self {
        case .apple:
            URL(string: "https://gs-loc.apple.com/")!
        case .google:
            URL(string: "https://www.google.com/")!
        case .microsoft:
            URL(string: "https://inference.location.live.net/")!
        case .yandex:
            URL(string: "https://api.lbs.yandex.net/")!
        case .mylnikov:
            URL(string: "https://api.mylnikov.org/")!
        }
    }

    var path: String {
        switch self {
        case .apple:
            "clls/wloc"
        case .google:
            "loc/m/api"
        case .microsoft:
            "inferenceservice/v21/Pox/GetLocationUsingFingerprint"
        case .yandex:
            "cellid_location/"
        case .mylnikov:
            "geolocation/wifi"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .apple, .google, .microsoft:
            .post
        case .yandex, .mylnikov:
            .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appending(path: path, directoryHint: .notDirectory)

        var request = URLRequest(url: url)
        request.method = method
        request.allHTTPHeaderFields = headers

        switch self {
        case .apple(let mac):
            let appleRequest = Apple_Request.with {
                $0.noise = 0
                $0.signal = 100
                $0.wifis = [
                    .with {
                        $0.mac = mac
                    }
                ]
            }

            let bytes: [UInt8] = (try? appleRequest.serializedBytes()) ?? []

            let size = Int16(truncatingIfNeeded: bytes.count).bytes

            let header = [
                [0x00, 0x01, 0x00, 0x05],
                "en_US".bytes,
                [0x00, 0x13],
                "com.apple.locationd".bytes,
                [0x00, 0x0c],
                "8.4.1.12H321".bytes,
                [0x00, 0x00, 0x00, 0x01, 0x00, 0x00]
            ]
            .flatMap { $0 }

            request.httpBody = Data([header, size, bytes].flatMap { $0 })
            return request
        case .google(let mac):
            let googleRequest = Google_Request.with {
                $0.header = .with {
                    $0.version = "2021"
                    $0.platform = "android/LEAGOO/full_wf562g_leagoo/wf562g_leagoo:6.0/MRA58K/1511161770:user/release-keys"
                    $0.locale = "en_US"
                }
                $0.locations = [
                    .with {
                        $0.data = .with {
                            $0.timestamp = 162723

                            if let mac = Int64(mac.replacingOccurrences(of: ":", with: ""), radix: 16), let temp = Int64("112233445566", radix: 16) {
                                $0.wifis = [
                                    .with {
                                        $0.text = ""
                                        $0.mac = mac
                                    },
                                    .with {
                                        $0.text = ""
                                        $0.mac = temp
                                    }
                                ]
                                $0.size = 2
                            } else {
                                $0.wifis = []
                                $0.size = 0
                            }
                        }
                    }
                ]
            }

            let bytes: [UInt8] = (try? googleRequest.serializedBytes()) ?? []

            let gzipped: [UInt8] = Array((try? Data(bytes).gzipped()) ?? Data())

            let size = Int32(truncatingIfNeeded: gzipped.count).bytes

            let header = [
                [0x00, 0x02, 0x00, 0x00, 0x1f],
                "location,2021,android,gms,en_US".bytes,
                [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01],
                "g".bytes,
                Int32(187).bytes,
                [0x00, 0x01, 0x01, 0x00, 0x01, 0x00, 0x08],
                "g:loc/ql".bytes,
                [0x00, 0x00, 0x00, 0x04],
                "POST".bytes,
                [0x6d, 0x72, 0x00, 0x00, 0x00, 0x04],
                "ROOT".bytes,
                [0x00],
                size,
                [0x00, 0x01],
                "g".bytes
            ]
            .flatMap { $0 }

            request.httpBody = Data([header, gzipped, [0x00, 0x00]].flatMap { $0 })
            return request
        case .microsoft(let mac):
            request.httpBody = Data("<GetLocationUsingFingerprint xmlns=\"http://inference.location.live.com\"><RequestHeader><Timestamp>\(Date.now.formatted(.iso8601.year().month().day().dateSeparator(.dash).timeZone(separator: .omitted).time(includingFractionalSeconds: true).timeSeparator(.colon)))</Timestamp><ApplicationId>e1e71f6b-2149-45f3-a298-a20682ab5017</ApplicationId><TrackingId>21BF9AD6-CFD3-46B3-B041-EE90BD34FDBC</TrackingId><DeviceProfile ClientGuid=\"0fc571be-4624-4ce0-b04e-911bdeb1a222\" Platform=\"Windows7\" DeviceType=\"PC\" OSVersion=\"7600.16695.amd64fre.win7_gdr.101026-1503\" LFVersion=\"9.0.8080.16413\" ExtendedDeviceInfo=\"\" /><Authorization /></RequestHeader><BeaconFingerprint><Detections><Wifi7 BssId=\"\(mac)\" rssi=\"-1\" /></Detections></BeaconFingerprint></GetLocationUsingFingerprint>".utf8)
            return request
        case .yandex(let mac):
            return try URLEncoding.queryString.encode(request, with: ["wifinetworks": "\(mac.replacingOccurrences(of: ":", with: "")):-65"])
        case .mylnikov(let mac):
            return try URLEncoding.queryString.encode(request, with: ["v": "1.1", "data": "open", "bssid": mac])
        }
    }

    var headers: [String: String]? {
        nil
    }
}
