import SwiftProtobuf

private struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
    struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
    typealias Version = _2
}

struct Apple_Request: Sendable {
    var wifis: [Apple_Request.RequestWifi] = []

    var noise: Int32 {
        get { return _noise ?? 0 }
        set { _noise = newValue }
    }

    var hasNoise: Bool { return _noise != nil }

    mutating func clearNoise() { _noise = nil }

    var signal: Int32 {
        get { return _signal ?? 100 }
        set { _signal = newValue }
    }

    var hasSignal: Bool { return _signal != nil }

    mutating func clearSignal() { _signal = nil }

    var unknownFields = SwiftProtobuf.UnknownStorage()

    struct RequestWifi: Sendable {
        var mac: String {
            get { return _mac ?? String() }
            set { _mac = newValue }
        }

        var hasMac: Bool { return _mac != nil }

        mutating func clearMac() { _mac = nil }

        var unknownFields = SwiftProtobuf.UnknownStorage()

        init() {}

        fileprivate var _mac: String? = nil
    }

    init() {}

    fileprivate var _noise: Int32? = nil
    fileprivate var _signal: Int32? = nil
}

struct Apple_Response: Sendable {
    var wifis: [Apple_Response.Wifi] = []

    var unknownFields = SwiftProtobuf.UnknownStorage()

    struct Wifi: Sendable {
        var location: Apple_Response.Wifi.Location {
            get { return _location ?? Apple_Response.Wifi.Location() }
            set { _location = newValue }
        }

        var hasLocation: Bool { return _location != nil }

        mutating func clearLocation() { _location = nil }

        var unknownFields = SwiftProtobuf.UnknownStorage()

        struct Location: Sendable {
            var latitude: Int64 {
                get { return _latitude ?? 0 }
                set { _latitude = newValue }
            }

            var hasLatitude: Bool { return _latitude != nil }

            mutating func clearLatitude() { _latitude = nil }

            var longitude: Int64 {
                get { return _longitude ?? 0 }
                set { _longitude = newValue }
            }

            var hasLongitude: Bool { return _longitude != nil }

            mutating func clearLongitude() { _longitude = nil }

            var unknownFields = SwiftProtobuf.UnknownStorage()

            init() {}

            fileprivate var _latitude: Int64? = nil
            fileprivate var _longitude: Int64? = nil
        }

        init() {}

        fileprivate var _location: Apple_Response.Wifi.Location? = nil
    }

    init() {}
}

private let _protobuf_package = "apple"

extension Apple_Request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = _protobuf_package + ".Request"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        2: .same(proto: "wifis"),
        3: .same(proto: "noise"),
        4: .same(proto: "signal"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 2: try decoder.decodeRepeatedMessageField(value: &wifis)
            case 3: try decoder.decodeSingularInt32Field(value: &_noise)
            case 4: try decoder.decodeSingularInt32Field(value: &_signal)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        if !wifis.isEmpty {
            try visitor.visitRepeatedMessageField(value: wifis, fieldNumber: 2)
        }
        try { if let v = self._noise {
            try visitor.visitSingularInt32Field(value: v, fieldNumber: 3)
        } }()
        try { if let v = self._signal {
            try visitor.visitSingularInt32Field(value: v, fieldNumber: 4)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Apple_Request, rhs: Apple_Request) -> Bool {
        if lhs.wifis != rhs.wifis { return false }
        if lhs._noise != rhs._noise { return false }
        if lhs._signal != rhs._signal { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Apple_Request.RequestWifi: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Apple_Request.protoMessageName + ".RequestWifi"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "mac"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularStringField(value: &_mac)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._mac {
            try visitor.visitSingularStringField(value: v, fieldNumber: 1)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Apple_Request.RequestWifi, rhs: Apple_Request.RequestWifi) -> Bool {
        if lhs._mac != rhs._mac { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Apple_Response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = _protobuf_package + ".Response"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        2: .same(proto: "wifis"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 2: try decoder.decodeRepeatedMessageField(value: &wifis)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        if !wifis.isEmpty {
            try visitor.visitRepeatedMessageField(value: wifis, fieldNumber: 2)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Apple_Response, rhs: Apple_Response) -> Bool {
        if lhs.wifis != rhs.wifis { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Apple_Response.Wifi: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Apple_Response.protoMessageName + ".Wifi"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        2: .same(proto: "location"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 2: try decoder.decodeSingularMessageField(value: &_location)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._location {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Apple_Response.Wifi, rhs: Apple_Response.Wifi) -> Bool {
        if lhs._location != rhs._location { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Apple_Response.Wifi.Location: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Apple_Response.Wifi.protoMessageName + ".Location"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "latitude"),
        2: .same(proto: "longitude"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularInt64Field(value: &_latitude)
            case 2: try decoder.decodeSingularInt64Field(value: &_longitude)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._latitude {
            try visitor.visitSingularInt64Field(value: v, fieldNumber: 1)
        } }()
        try { if let v = self._longitude {
            try visitor.visitSingularInt64Field(value: v, fieldNumber: 2)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Apple_Response.Wifi.Location, rhs: Apple_Response.Wifi.Location) -> Bool {
        if lhs._latitude != rhs._latitude { return false }
        if lhs._longitude != rhs._longitude { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}
