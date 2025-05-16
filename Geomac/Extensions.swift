import Foundation
import SwiftUI
import SwiftyXMLParser

extension FixedWidthInteger {
    var bytes: [UInt8] {
        withUnsafeBytes(of: bigEndian, Array.init)
    }
}

extension StringProtocol {
    var bytes: [UInt8] {
        Array(Data(utf8))
    }
}

extension [XML.Element] {
    func find(_ predicate: (Self.Element) throws -> Bool) rethrows -> XML.Element? {
        if let result = try first(where: predicate) {
            return result
        } else {
            for element in self {
                if let result = try element.childElements.find(predicate) {
                    return result
                }
            }
        }

        return nil
    }
}

extension View {
    @ViewBuilder func imageFill(
        _ ratio: CGFloat? = nil
    ) -> some View {
        aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(ratio, contentMode: .fit)
    }
}
