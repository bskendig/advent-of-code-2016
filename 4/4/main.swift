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
    let characters = name.characters.filter({$0 != "-"})
    var freq: [Character : Int] = [:]
    for character in characters {
        if freq[character] == nil { freq[character] = 1 }
        else { freq[character]! += 1 }
    }
    var s: [Character] = Array(freq.keys).sorted(by: { k1, k2 in
        if freq[k1] != freq[k2] { return freq[k1]! > freq[k2]! }
        else { return k1 < k2 }
    })
    return String(s[0...4])
}

func sectorId(_ room: String) -> Int {
    let regex = try! NSRegularExpression(pattern: "^(.+)-(\\d+)\\[(.+)\\]$", options: [])
    let matches = regex.matches(in: room, options: [], range: NSMakeRange(0, room.characters.count))
    if matches.isEmpty { return 0 }
    let name = (room as NSString).substring(with: matches[0].rangeAt(1))
    let id = Int((room as NSString).substring(with: matches[0].rangeAt(2)))!
    let cksum = (room as NSString).substring(with: matches[0].rangeAt(3))
    print("\(name), \(id), \(cksum)")
    if cksum == checksum(name) { return id }
    else { return 0 }
}

func main() {
    let rooms = getInput().components(separatedBy: "\n")
    var sum = 0
    for room in rooms {
        sum += sectorId(room)
    }
    print(sum)
}

main()
