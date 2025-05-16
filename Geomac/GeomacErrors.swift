import Foundation

enum GeomacErrors: Error {
    case notFound
}

extension GeomacErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            String(localized: "key.error.notFound")
        }
    }
}

extension GeomacErrors: CustomNSError {
    var errorUserInfo: [String: Any] {
        if let errorDescription {
            [NSLocalizedDescriptionKey: errorDescription]
        } else {
            [:]
        }
    }
}
