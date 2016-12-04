//
//  main.swift
//  4
//
//  Created by Brian Kendig on 12/4/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue) as String
}

func checksum(_ name: String) -> String {
    var frequencies: [Character : Int] = [:]
    for character in name.characters.filter({$0 != "-"}) {
        if frequencies[character] == nil { frequencies[character] = 1 }
        else { frequencies[character]! += 1 }
    }
    var sortedCharacters: [Character] = Array(frequencies.keys).sorted(by: { c1, c2 in
        if frequencies[c1] != frequencies[c2] { return frequencies[c1]! > frequencies[c2]! }
        else { return c1 < c2 }
    })
    return String(sortedCharacters[0...4])  // assuming there are always at least five different characters
}

func decrypt(_ s: String, key: Int) -> String {
    let start = UnicodeScalar("a").value
    let s2: [UnicodeScalar] = s.unicodeScalars.map { c -> UnicodeScalar in
        if c == "-" { return " " }
        let newOffset = (c.value - start + UInt32(key)) % 26
        return UnicodeScalar(start + newOffset)!
    }
    return s2.map({ $0.description }).joined()
}

func room(_ room: String) -> (name: String, id: Int)? {
    let regex = try! NSRegularExpression(pattern: "^(.+)-(\\d+)\\[(.+)\\]$", options: [])
    let matches = regex.matches(in: room, options: [], range: NSMakeRange(0, room.characters.count))
    if matches.isEmpty { return nil }
    let name = (room as NSString).substring(with: matches[0].rangeAt(1))
    let id = Int((room as NSString).substring(with: matches[0].rangeAt(2)))!
    let cksum = (room as NSString).substring(with: matches[0].rangeAt(3))
    if cksum == checksum(name) { return (decrypt(name, key: id), id) }
    else { return nil }
}

func main() {
    let entries = getInput().components(separatedBy: "\n")
    var sum = 0
    for entry in entries {
        guard let r = room(entry) else {
            continue
        }
        sum += r.id
        print("\(r.id): \(r.name)")
    }
    print("Sum of real room IDs is \(sum).")
}

main()
