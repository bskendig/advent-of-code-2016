//
//  main.swift
//  5
//
//  Created by Brian Kendig on 12/5/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

func md5(_ s: String) -> Data? {
    guard let message = s.data(using: String.Encoding.utf8) else { return nil }
    var digest = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    autoreleasepool {
        _ = digest.withUnsafeMutableBytes { digestBytes in
            message.withUnsafeBytes { messageBytes in
                CC_MD5(messageBytes, CC_LONG(message.count), digestBytes)
            }
        }
    }
    return digest
}


func main() {
    let doorID = "ojvtpuvg"
    let length = 8
    var password = [UInt8](repeating: 0, count: length)
    var offset = 0, index = 0
    while offset < length {
        let key = doorID + String(index)
        guard let data = md5(key) else { break }
        if data[0] == 0x00 && data[1] == 0x00 && data[2] < 0x10 {
            print(data[2])
            password[offset] = data[2]
            offset += 1
        }
        index += 1
    }
    print(password.map({ String(format:"%2X", $0) }).joined())
}

main()
