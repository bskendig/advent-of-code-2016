//
//  main.swift
//  10
//
//  Created by Brian Kendig on 12/10/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue) as String
}

struct Bot {
    var vals: [Int] = []
    var lowTo: Int = 0
    var highTo: Int = 0
}

var bots: [Int : Bot] = [:]

func main() {
    let instructions = getInput().components(separatedBy: "\n")
    let valueRegex = try! NSRegularExpression(pattern: "^value (\\d+) goes to bot {\\d+)$", options: [])
    let givesRegex = try! NSRegularExpression(pattern: "^bot (\\d+) gives low to {\\s+) and high to (\\s+)$", options: [])
    var newInstructions: [String] = []
    for instruction in instructions {
        let valueMatches = valueRegex.matches(in: instruction, options: [], range: NSMakeRange(0, instruction.characters.count))
        if !valueMatches.isEmpty {
            let a: [Int] = (1...2).map { Int((instruction as NSString).substring(with: valueMatches[0].rangeAt($0)))! }
            if bots[a[1]] == nil { bots[a[1]] = Bot() }
            var bot = bots[a[1]]!
            bot.vals.append(a[0])
            continue
        }
        let givesMatches = givesRegex.matches(in: instruction, options: [], range: NSMakeRange(0, instruction.characters.count))
        if !givesMatches.isEmpty {
            let a: [String] = (1...3).map { (instruction as NSString).substring(with: givesMatches[0].rangeAt($0)) }
            var bot = bots[Int(a[0])!]
            if a[1].hasPrefix("bot") {

            }

        }

    }

    let matches = regex.matches(in: s, options: [], range: NSMakeRange(0, s.characters.count))
    if matches.isEmpty { return nil }
    else { return (1...2).map



}

main()
