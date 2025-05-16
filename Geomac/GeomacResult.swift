import Foundation
import SwiftData

@Model
class GeomacResult {
    @Attribute(.unique)
    private(set) var mac: String

    var apple: Coordinates?
    var google: Coordinates?
    var microsoft: Coordinates?
    var yandex: Coordinates?
    var mylnikov: Coordinates?

    init(mac: String) {
        self.mac = mac
        self.apple = nil
        self.google = nil
        self.microsoft = nil
        self.yandex = nil
        self.mylnikov = nil
    }
}

@Model
class Coordinates {
    private(set) var latitude: Double?
    private(set) var longitude: Double?

    init(latitude: Double? = nil, longitude: Double? = nil) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
