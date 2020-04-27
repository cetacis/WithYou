import Foundation
import CryptoKit

// CryptoKit.Digest utils
extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}

func Encrypt_sha256(data: String) -> String {
    guard let x = data.data(using: .utf8) else { return data}
    let d = SHA256.hash(data: x)
    return d.hexStr
}
