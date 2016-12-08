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

func containsAbba(_ s: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: "(.)(.)\\2\\1", options: [])
    let matches = regex.matches(in: s, options: [], range: NSMakeRange(0, s.characters.count))
    if matches.isEmpty { return false }
    let a = (1...2).map { ((s as NSString).substring(with: matches[0].rangeAt($0))) }
    if a[0] == a[1] { return false }
    return true
}

func tripletsInString(_ s: String) -> [String] {
    // we're only going to represent triplets as "ab", because "aba" would be redundant and harder to reverse
    var ssl: [String] = []
    let chars = Array(s.characters)
    for i in 0..<(chars.count - 2) {
        if chars[i] == chars[i+2] && chars[i] != chars[i+1] {
            ssl.append(String(chars[i...i+1]))
        }
    }
    return ssl
}

func main() {
    let addresses = getInput().components(separatedBy: "\n")
    var tlsCount = 0, sslCount = 0
    for address in addresses {
        if address.isEmpty { continue }
        let parts = address.characters.split { $0 == "[" || $0 == "]" }

        // part 1
        let checkPartsForAbba = parts.map { containsAbba(String($0)) }
        var hasGood = false, hasBad = false
        for (i, hasAbba) in checkPartsForAbba.enumerated() {
            if hasAbba && i % 2 == 0 { hasGood = true }
            if hasAbba && i % 2 == 1 { hasBad = true }
        }
        if hasGood && !hasBad { tlsCount += 1 }

        // part 2
        let checkPartsForTriplets = parts.map { tripletsInString(String($0)) }
        var abaList: [String] = [], babList: [String] = []
        for (i, triplets) in checkPartsForTriplets.enumerated() {
            if i % 2 == 0 { abaList += triplets }
            else { babList += triplets.map { String($0.characters.reversed()) } }
        }
        var hasSsl = false
        for aba in abaList {
            if babList.contains(aba) {
                hasSsl = true
                break
            }
        }
        if hasSsl { sslCount += 1 }
    }
    print("\(tlsCount) IPs support TLS.")
    print("\(sslCount) IPs support SSL.")
}

main()
