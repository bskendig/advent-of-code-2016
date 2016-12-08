//
//  main.swift
//  7
//
//  Created by Brian Kendig on 12/7/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue) as String
}

func containsPalindrome(_ s: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: "(.)(.)\\2\\1", options: [])
    let matches = regex.matches(in: s, options: [], range: NSMakeRange(0, s.characters.count))
    if matches.isEmpty { return false }
    let a = (1...2).map { ((s as NSString).substring(with: matches[0].rangeAt($0))) }
    if a[0] == a[1] { return false }
    print("\(a[0])\(a[1])\(a[1])\(a[0])")
    return true
}

func main() {
    let addresses = getInput().components(separatedBy: "\n")
    var count = 0
    for address in addresses {
        if address.isEmpty { continue }
        let parts = address.characters.split { $0 == "[" || $0 == "]" }
        let checkParts = parts.map { containsPalindrome(String($0)) }
        var hasGood = false, hasBad = false
        for (i, hasAbba) in checkParts.enumerated() {
            if hasAbba && i % 2 == 0 { hasGood = true }
            if hasAbba && i % 2 == 1 { hasBad = true }
        }
        if hasGood && !hasBad { count += 1 }
    }
    print(count)
}

main()
