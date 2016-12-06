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
    let passwordLength = 8
    var password1 = [String](repeating: " ", count: passwordLength), offset1 = 0
    var password2 = [String](repeating: " ", count: passwordLength), donePassword2 = false
    var index = 0
    while offset1 < passwordLength || !donePassword2 {
        let key = doorID + String(index)
        guard let data = md5(key) else { break }
        if data[0] == 0x00 && data[1] == 0x00 && data[2] < 0x10 {
            // part 1
            if offset1 < passwordLength {
                password1[offset1] = String(format:"%X", data[2])
                offset1 += 1
            }
            // part 2
            let pos = Int(data[2]), val = UInt8(data[3] / 16)
            if pos < passwordLength && password2[pos] == " " {
                password2[pos] = String(format:"%X", val)
                donePassword2 = password2.index(of: " ") == nil
            }
        }
        index += 1
    }
    print(password1.joined())
    print(password2.joined())
}

main()
