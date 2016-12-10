//
//  main.swift
//  9
//
//  Created by Brian Kendig on 12/9/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue) as String
}

let repeatRegex = try! NSRegularExpression(pattern: "^\\((\\d+)x(\\d+)\\)$", options: [])
func doRepeat(_ repeatString: String, s: String) -> (String, String) {
    let matches = repeatRegex.matches(in: repeatString, options: [], range: NSMakeRange(0, repeatString.characters.count))
    let a = (1...2).map { Int((repeatString as NSString).substring(with: matches[0].rangeAt($0)))! }
    let stringToRepeat = s.substring(to: s.index(s.startIndex, offsetBy: a[0]))
    var repeatedString = ""
    for _ in 1...a[1] {
        repeatedString += stringToRepeat
    }
    let remaining = s.substring(from: s.index(s.startIndex, offsetBy: a[0]))
    return (repeatedString, remaining)
}

func main() {
    let markerRegex = try! NSRegularExpression(pattern: "(\\(\\d+x\\d+\\))", options: [])
    var done = ""
    var remaining = getInput().replacingOccurrences(of: "\n", with: "", options: [])
    while remaining != "" {
        let matches = markerRegex.matches(in: remaining, options: [], range: NSMakeRange(0, remaining.characters.count))
        if matches.isEmpty {
            done += remaining
            remaining = ""
        } else {
            let markerRange = matches[0].rangeAt(1)
            done += remaining.substring(to: remaining.index(remaining.startIndex, offsetBy: markerRange.location))  // before marker
            let marker = (remaining as NSString).substring(with: markerRange)
            remaining = remaining.substring(from: remaining.index(remaining.startIndex, offsetBy: markerRange.location + markerRange.length))

            let result = doRepeat(marker, s: remaining)
            done += result.0
            remaining = result.1
        }
    }
    print(done)
    print(done.characters.count)
}

main()
