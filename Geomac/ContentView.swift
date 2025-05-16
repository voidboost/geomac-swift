import Algorithms
import Combine
import SwiftData
import SwiftUI

struct ContentView: View {
    private let geomac = GeomacRepository()
    private let regex = /^(?:[0-9A-Fa-f]{2}[\s.:-]?){5}[0-9A-Fa-f]{2}$/

    @State private var query: String = ""
    @State private var subscription: Set<AnyCancellable> = []
    
    @Query(sort: \GeomacResult.mac) private var results: [GeomacResult]
    @Environment(\.modelContext) private var modelContext
    
    @State private var height: CGFloat = .zero

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack(spacing: 15) {
                TextField("Mac", text: $query, prompt: Text("Enter your MAC address (BSSID)"))
                    .textFieldStyle(.plain)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(.quinary)
                    .cornerRadius(6)
                    .overlay {
                        HStack(alignment: .center) {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)
                                .padding(.leading, 8)
                            
                            Spacer()
                            
                            if !query.isEmpty {
                                Button {
                                    query = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundStyle(.secondary)
                                        .padding(.trailing, 8)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .onSubmit {
                        for mac in query.trimmingCharacters(in: .whitespacesAndNewlines).matches(of: regex).map(\.output) {
                            search(mac: mac)
                        }
                    }
                    .onGeometryChange(for: CGFloat.self) { geometry in
                        geometry.size.height
                    } action: { height in
                        self.height = height
                    }
                
                Button {
                    for mac in query.trimmingCharacters(in: .whitespacesAndNewlines).matches(of: regex).map(\.output) {
                        search(mac: mac)
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .bold()
                        .foregroundStyle(Color.accentColor)
                        .imageFill(1)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .contentShape(RoundedRectangle(cornerRadius: 6))
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.accentColor, lineWidth: 1)
                        }
                }
                .disabled(query.trimmingCharacters(in: .whitespacesAndNewlines).matches(of: regex).map(\.output).isEmpty)
                .animation(.easeInOut, value: query.trimmingCharacters(in: .whitespacesAndNewlines).matches(of: regex).map(\.output).isEmpty)
                .buttonStyle(.plain)
            }
            .frame(height: height)
            
            ScrollView(.vertical) {
                LazyVStack(alignment: .center, spacing: 15) {
                    ForEach(results.filter { $0.mac.contains(query.trimmingCharacters(in: .whitespacesAndNewlines).uppercased().replacing(/[\s.:-]+/, with: "").chunks(ofCount: 2).joined(separator: ":")) || query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }, id: \.mac) { result in
                        VStack(spacing: 0) {
                            HStack {
                                Text(result.mac)
                                    .font(.system(size: 17, weight: .semibold))
                                    .monospaced()
                                    .textSelection(.enabled)
                                
                                Spacer()
                                
                                Button {
                                    search(mac: result.mac)
                                } label: {
                                    Image(systemName: "arrow.trianglehead.clockwise")
                                        .padding(5)
                                }
                                .buttonStyle(.accessoryBar)
                            }
                            .frame(height: 40)
                                    
                            Divider()
                                    
                            HStack {
                                Text("Apple")
                                        
                                Spacer()
                                        
                                if let coordinates = result.apple {
                                    if let latitude = coordinates.latitude, let longitude = coordinates.longitude {
                                        Text("\(String(format: "%.6f", latitude)), \(String(format: "%.6f", longitude))")
                                            .monospacedDigit()
                                            .textSelection(.enabled)
                                    } else {
                                        Text("Not found")
                                    }
                                } else {
                                    ProgressView()
                                        .scaleEffect(0.65)
                                }
                            }
                            .frame(height: 40)
                            .animation(.easeInOut, value: result.apple)
                                    
                            Divider()
                                    
                            HStack {
                                Text("Google")
                                        
                                Spacer()
                                        
                                if let coordinates = result.google {
                                    if let latitude = coordinates.latitude, let longitude = coordinates.longitude {
                                        Text("\(String(format: "%.6f", latitude)), \(String(format: "%.6f", longitude))")
                                            .monospacedDigit()
                                            .textSelection(.enabled)
                                    } else {
                                        Text("Not found")
                                    }
                                } else {
                                    ProgressView()
                                        .scaleEffect(0.65)
                                }
                            }
                            .frame(height: 40)
                            .animation(.easeInOut, value: result.google)
                                    
                            Divider()
                                    
                            HStack {
                                Text("Microsoft")
                                        
                                Spacer()
                                        
                                if let coordinates = result.microsoft {
                                    if let latitude = coordinates.latitude, let longitude = coordinates.longitude {
                                        Text("\(String(format: "%.6f", latitude)), \(String(format: "%.6f", longitude))")
                                            .monospacedDigit()
                                            .textSelection(.enabled)
                                    } else {
                                        Text("Not found")
                                    }
                                } else {
                                    ProgressView()
                                        .scaleEffect(0.65)
                                }
                            }
                            .frame(height: 40)
                            .animation(.easeInOut, value: result.microsoft)
                                    
                            Divider()
                                    
                            HStack {
                                Text("Yandex")
                                        
                                Spacer()
                                        
                                if let coordinates = result.yandex {
                                    if let latitude = coordinates.latitude, let longitude = coordinates.longitude {
                                        Text("\(String(format: "%.6f", latitude)), \(String(format: "%.6f", longitude))")
                                            .monospacedDigit()
                                            .textSelection(.enabled)
                                    } else {
                                        Text("Not found")
                                    }
                                } else {
                                    ProgressView()
                                        .scaleEffect(0.65)
                                }
                            }
                            .frame(height: 40)
                            .animation(.easeInOut, value: result.yandex)
                                    
                            Divider()
                                    
                            HStack {
                                Text("Mylnikov")
                                        
                                Spacer()
                                        
                                if let coordinates = result.mylnikov {
                                    if let latitude = coordinates.latitude, let longitude = coordinates.longitude {
                                        Text("\(String(format: "%.6f", latitude)), \(String(format: "%.6f", longitude))")
                                            .monospacedDigit()
                                            .textSelection(.enabled)
                                    } else {
                                        Text("Not found")
                                    }
                                } else {
                                    ProgressView()
                                        .scaleEffect(0.65)
                                }
                            }
                            .frame(height: 40)
                            .animation(.easeInOut, value: result.mylnikov)
                        }
                        .padding(.horizontal, 15)
                        .background(.quinary)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .contentShape(RoundedRectangle(cornerRadius: 6))
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.tertiary, lineWidth: 1)
                        }
                        .font(.system(size: 13))
                        .contextMenu {
                            Button {
                                modelContext.delete(result)
                            } label: {
                                Text("Delete")
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.never)
            .overlay {
                if results.filter({ $0.mac.contains(query.trimmingCharacters(in: .whitespacesAndNewlines).uppercased().replacing(/[\s.:-]+/, with: "").chunks(ofCount: 2).joined(separator: ":")) || query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }).isEmpty {
                    Text("Empty")
                        .foregroundStyle(.secondary)
                }
            }
            .animation(.easeInOut, value: results)
        }
        .padding(15)
        .background(.background)
        .frame(width: 600, height: 400)
    }
    
    private func search(mac: any StringProtocol) {
        let normalizedMac = mac.uppercased().replacing(/[\s.:-]+/, with: "").chunks(ofCount: 2).joined(separator: ":")
        
        let result = {
            if let result = results.first(where: { $0.mac == normalizedMac }) {
                return result
            } else {
                let result = GeomacResult(mac: normalizedMac)
            
                modelContext.insert(result)
            
                return result
            }
        }()
        
        if result.apple?.latitude == nil, result.apple?.longitude == nil {
            result.apple = nil
        }
        
        if result.google?.latitude == nil, result.google?.longitude == nil {
            result.google = nil
        }
        
        if result.microsoft?.latitude == nil, result.microsoft?.longitude == nil {
            result.microsoft = nil
        }
        
        if result.yandex?.latitude == nil, result.yandex?.longitude == nil {
            result.yandex = nil
        }
        
        if result.mylnikov?.latitude == nil, result.mylnikov?.longitude == nil {
            result.mylnikov = nil
        }
        
        geomac
            .apple(mac: normalizedMac)
            .sink { completion in
                guard case .failure = completion,
                      result.apple?.latitude == nil,
                      result.apple?.longitude == nil
                else {
                    return
                }
                
                result.apple = .init()
            } receiveValue: { latitude, longitude in
                result.apple = .init(latitude: latitude, longitude: longitude)
            }
            .store(in: &subscription)
        
        geomac
            .google(mac: normalizedMac)
            .sink { completion in
                guard case .failure = completion,
                      result.google?.latitude == nil,
                      result.google?.longitude == nil
                else {
                    return
                }
                
                result.google = .init()
            } receiveValue: { latitude, longitude in
                result.google = .init(latitude: latitude, longitude: longitude)
            }
            .store(in: &subscription)
        
        geomac
            .microsoft(mac: normalizedMac)
            .sink { completion in
                guard case .failure = completion,
                      result.microsoft?.latitude == nil,
                      result.microsoft?.longitude == nil
                else {
                    return
                }
                
                result.microsoft = .init()
            } receiveValue: { latitude, longitude in
                result.microsoft = .init(latitude: latitude, longitude: longitude)
            }
            .store(in: &subscription)
        
        geomac
            .yandex(mac: normalizedMac)
            .sink { completion in
                guard case .failure = completion,
                      result.yandex?.latitude == nil,
                      result.yandex?.longitude == nil
                else {
                    return
                }
                
                result.yandex = .init()
            } receiveValue: { latitude, longitude in
                result.yandex = .init(latitude: latitude, longitude: longitude)
            }
            .store(in: &subscription)
        
        geomac
            .mylnikov(mac: normalizedMac)
            .sink { completion in
                guard case .failure = completion,
                      result.mylnikov?.latitude == nil,
                      result.mylnikov?.longitude == nil
                else {
                    return
                }
                
                result.mylnikov = .init()
            } receiveValue: { latitude, longitude in
                result.mylnikov = .init(latitude: latitude, longitude: longitude)
            }
            .store(in: &subscription)
    }
}
