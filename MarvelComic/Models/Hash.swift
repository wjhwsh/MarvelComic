//
//  Hash.swift
//  MarvelComic
//
//  Created by Jianhua Wang on 8/8/21.
//

import Foundation
import CommonCrypto

func md5(string: String) -> String {
    if let data = string.data(using: .utf8) {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = data.withUnsafeBytes {
            CC_MD5($0.baseAddress, UInt32(data.count), &digest)
        }
        return digest.reduce("") { $0 + String(format: "%02x", UInt8($1))}
    } else {
        return ""
    }
}

