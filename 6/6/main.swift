//
//  main.swift
//  6
//
//  Created by Brian Kendig on 12/6/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue) as String
}

func main() {
    let messages = getInput().components(separatedBy: "\n")
    var freq: [[Character: Int]] = []
    var answer1 = "", answer2 = ""
    for message in messages {
        for (i, c) in message.characters.enumerated() {
            if freq.count <= i { freq.append([:]) }
            freq[i][c] = (freq[i][c] == nil) ? 1 : freq[i][c]! + 1
        }
    }
    for position in freq {
        let sorted = position.sorted(by: { $0.1 > $1.1 })
        answer1 += String(sorted.first!.0)
        answer2 += String(sorted.last!.0)
    }
    print(answer1)
    print(answer2)
}

main()
