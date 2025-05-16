import SwiftProtobuf

private struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
    struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
    typealias Version = _2
}

struct Google_Request: Sendable {
    var header: Google_Request.Header {
        get { return _header ?? Google_Request.Header() }
        set { _header = newValue }
    }

    var hasHeader: Bool { return _header != nil }

    mutating func clearHeader() { _header = nil }

    var locations: [Google_Request.Location] = []

    var unknownFields = SwiftProtobuf.UnknownStorage()

    struct Header: Sendable {
        var version: String {
            get { return _version ?? String() }
            set { _version = newValue }
        }

        var hasVersion: Bool { return _version != nil }

        mutating func clearVersion() { _version = nil }

        var platform: String {
            get { return _platform ?? String() }
            set { _platform = newValue }
        }

        var hasPlatform: Bool { return _platform != nil }

        mutating func clearPlatform() { _platform = nil }

        var locale: String {
            get { return _locale ?? String() }
            set { _locale = newValue }
        }

        var hasLocale: Bool { return _locale != nil }

        mutating func clearLocale() { _locale = nil }

        var unknownFields = SwiftProtobuf.UnknownStorage()

        init() {}

        fileprivate var _version: String? = nil
        fileprivate var _platform: String? = nil
        fileprivate var _locale: String? = nil
    }

    struct Location: Sendable {
        var data: Google_Request.Location.DataMessage {
            get { return _data ?? Google_Request.Location.DataMessage() }
            set { _data = newValue }
        }

        var hasData: Bool { return _data != nil }

        mutating func clearData() { _data = nil }

        var unknownFields = SwiftProtobuf.UnknownStorage()

        struct DataMessage: Sendable {
            var timestamp: Int64 {
                get { return _timestamp ?? 0 }
                set { _timestamp = newValue }
            }

            var hasTimestamp: Bool { return _timestamp != nil }

            mutating func clearTimestamp() { _timestamp = nil }

            var wifis: [Google_Request.Location.DataMessage.Wifi] = []

            var size: Int32 {
                get { return _size ?? 0 }
                set { _size = newValue }
            }

            var hasSize: Bool { return _size != nil }

            mutating func clearSize() { _size = nil }

            var unknownFields = SwiftProtobuf.UnknownStorage()

            struct Wifi: Sendable {
                var text: String {
                    get { return _text ?? String() }
                    set { _text = newValue }
                }

                var hasText: Bool { return _text != nil }

                mutating func clearText() { _text = nil }

                var mac: Int64 {
                    get { return _mac ?? 0 }
                    set { _mac = newValue }
                }

                var hasMac: Bool { return _mac != nil }

                mutating func clearMac() { _mac = nil }

                var unknownFields = SwiftProtobuf.UnknownStorage()

                init() {}

                fileprivate var _text: String? = nil
                fileprivate var _mac: Int64? = nil
            }

            init() {}

            fileprivate var _timestamp: Int64? = nil
            fileprivate var _size: Int32? = nil
        }

        init() {}

        fileprivate var _data: Google_Request.Location.DataMessage? = nil
    }

    init() {}

    fileprivate var _header: Google_Request.Header? = nil
}

struct Google_Response: Sendable {
    var data: Google_Response.DataMessage {
        get { return _data ?? Google_Response.DataMessage() }
        set { _data = newValue }
    }

    var hasData: Bool { return _data != nil }

    mutating func clearData() { _data = nil }

    var unknownFields = SwiftProtobuf.UnknownStorage()

    struct DataMessage: Sendable {
        var wifis: [Google_Response.DataMessage.Wifi] = []

        var unknownFields = SwiftProtobuf.UnknownStorage()

        struct Wifi: Sendable {
            var wifiData: Google_Response.DataMessage.Wifi.WifiData {
                get { return _wifiData ?? Google_Response.DataMessage.Wifi.WifiData() }
                set { _wifiData = newValue }
            }

            var hasWifiData: Bool { return _wifiData != nil }

            mutating func clearWifiData() { _wifiData = nil }

            var unknownFields = SwiftProtobuf.UnknownStorage()

            struct WifiData: Sendable {
                var location: Google_Response.DataMessage.Wifi.WifiData.Location {
                    get { return _location ?? Google_Response.DataMessage.Wifi.WifiData.Location() }
                    set { _location = newValue }
                }

                var hasLocation: Bool { return _location != nil }

                mutating func clearLocation() { _location = nil }

                var unknownFields = SwiftProtobuf.UnknownStorage()

                struct Location: Sendable {
                    var latitude: UInt32 {
                        get { return _latitude ?? 0 }
                        set { _latitude = newValue }
                    }

                    var hasLatitude: Bool { return _latitude != nil }

                    mutating func clearLatitude() { _latitude = nil }

                    var longitude: UInt32 {
                        get { return _longitude ?? 0 }
                        set { _longitude = newValue }
                    }

                    var hasLongitude: Bool { return _longitude != nil }

                    mutating func clearLongitude() { _longitude = nil }

                    var unknownFields = SwiftProtobuf.UnknownStorage()

                    init() {}

                    fileprivate var _latitude: UInt32? = nil
                    fileprivate var _longitude: UInt32? = nil
                }

                init() {}

                fileprivate var _location: Google_Response.DataMessage.Wifi.WifiData.Location? = nil
            }

            init() {}

            fileprivate var _wifiData: Google_Response.DataMessage.Wifi.WifiData? = nil
        }

        init() {}
    }

    init() {}

    fileprivate var _data: Google_Response.DataMessage? = nil
}

private let _protobuf_package = "google"

extension Google_Request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = _protobuf_package + ".Request"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "header"),
        4: .same(proto: "locations"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularMessageField(value: &_header)
            case 4: try decoder.decodeRepeatedMessageField(value: &locations)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._header {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
        } }()
        if !locations.isEmpty {
            try visitor.visitRepeatedMessageField(value: locations, fieldNumber: 4)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Request, rhs: Google_Request) -> Bool {
        if lhs._header != rhs._header { return false }
        if lhs.locations != rhs.locations { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Google_Request.Header: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Google_Request.protoMessageName + ".Header"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "version"),
        2: .same(proto: "platform"),
        5: .same(proto: "locale"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularStringField(value: &_version)
            case 2: try decoder.decodeSingularStringField(value: &_platform)
            case 5: try decoder.decodeSingularStringField(value: &_locale)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._version {
            try visitor.visitSingularStringField(value: v, fieldNumber: 1)
        } }()
        try { if let v = self._platform {
            try visitor.visitSingularStringField(value: v, fieldNumber: 2)
        } }()
        try { if let v = self._locale {
            try visitor.visitSingularStringField(value: v, fieldNumber: 5)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Request.Header, rhs: Google_Request.Header) -> Bool {
        if lhs._version != rhs._version { return false }
        if lhs._platform != rhs._platform { return false }
        if lhs._locale != rhs._locale { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Google_Request.Location: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Google_Request.protoMessageName + ".Location"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        2: .same(proto: "data"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 2: try decoder.decodeSingularMessageField(value: &_data)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._data {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Request.Location, rhs: Google_Request.Location) -> Bool {
        if lhs._data != rhs._data { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Google_Request.Location.DataMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Google_Request.Location.protoMessageName + ".Data"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "timestamp"),
        2: .same(proto: "wifis"),
        3: .same(proto: "size"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularInt64Field(value: &_timestamp)
            case 2: try decoder.decodeRepeatedMessageField(value: &wifis)
            case 3: try decoder.decodeSingularInt32Field(value: &_size)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._timestamp {
            try visitor.visitSingularInt64Field(value: v, fieldNumber: 1)
        } }()
        if !wifis.isEmpty {
            try visitor.visitRepeatedMessageField(value: wifis, fieldNumber: 2)
        }
        try { if let v = self._size {
            try visitor.visitSingularInt32Field(value: v, fieldNumber: 3)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Request.Location.DataMessage, rhs: Google_Request.Location.DataMessage) -> Bool {
        if lhs._timestamp != rhs._timestamp { return false }
        if lhs.wifis != rhs.wifis { return false }
        if lhs._size != rhs._size { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Google_Request.Location.DataMessage.Wifi: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Google_Request.Location.DataMessage.protoMessageName + ".Wifi"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "text"),
        8: .same(proto: "mac"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularStringField(value: &_text)
            case 8: try decoder.decodeSingularInt64Field(value: &_mac)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._text {
            try visitor.visitSingularStringField(value: v, fieldNumber: 1)
        } }()
        try { if let v = self._mac {
            try visitor.visitSingularInt64Field(value: v, fieldNumber: 8)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Request.Location.DataMessage.Wifi, rhs: Google_Request.Location.DataMessage.Wifi) -> Bool {
        if lhs._text != rhs._text { return false }
        if lhs._mac != rhs._mac { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Google_Response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = _protobuf_package + ".Response"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        2: .same(proto: "data"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 2: try decoder.decodeSingularMessageField(value: &_data)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._data {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Response, rhs: Google_Response) -> Bool {
        if lhs._data != rhs._data { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Google_Response.DataMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Google_Response.protoMessageName + ".Data"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        3: .same(proto: "wifis"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 3: try decoder.decodeRepeatedMessageField(value: &wifis)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        if !wifis.isEmpty {
            try visitor.visitRepeatedMessageField(value: wifis, fieldNumber: 3)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Response.DataMessage, rhs: Google_Response.DataMessage) -> Bool {
        if lhs.wifis != rhs.wifis { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Google_Response.DataMessage.Wifi: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Google_Response.DataMessage.protoMessageName + ".Wifi"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "wifiData"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularMessageField(value: &_wifiData)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._wifiData {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Response.DataMessage.Wifi, rhs: Google_Response.DataMessage.Wifi) -> Bool {
        if lhs._wifiData != rhs._wifiData { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Google_Response.DataMessage.Wifi.WifiData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Google_Response.DataMessage.Wifi.protoMessageName + ".WifiData"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "location"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularMessageField(value: &_location)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._location {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Response.DataMessage.Wifi.WifiData, rhs: Google_Response.DataMessage.Wifi.WifiData) -> Bool {
        if lhs._location != rhs._location { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension Google_Response.DataMessage.Wifi.WifiData.Location: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = Google_Response.DataMessage.Wifi.WifiData.protoMessageName + ".Location"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "latitude"),
        2: .same(proto: "longitude"),
    ]

    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularFixed32Field(value: &_latitude)
            case 2: try decoder.decodeSingularFixed32Field(value: &_longitude)
            default: break
            }
        }
    }

    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try { if let v = self._latitude {
            try visitor.visitSingularFixed32Field(value: v, fieldNumber: 1)
        } }()
        try { if let v = self._longitude {
            try visitor.visitSingularFixed32Field(value: v, fieldNumber: 2)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    static func ==(lhs: Google_Response.DataMessage.Wifi.WifiData.Location, rhs: Google_Response.DataMessage.Wifi.WifiData.Location) -> Bool {
        if lhs._latitude != rhs._latitude { return false }
        if lhs._longitude != rhs._longitude { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}
