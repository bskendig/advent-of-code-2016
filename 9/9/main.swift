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

let markerRegex = try! NSRegularExpression(pattern: "\\((\\d+)x(\\d+)\\)", options: [])
func decompressedLengthOf(_ s: String, usingDecompressedMarkers m: Bool = false) -> Int {
    let matches = markerRegex.matches(in: s, options: [], range: NSMakeRange(0, s.characters.count))
    if matches.isEmpty { return s.characters.count }
    let a = (1...2).map { Int((s as NSString).substring(with: matches[0].rangeAt($0)))! }
    // now a[0] is the sequence length, a[1] is the number of copies
    let stringBeforeMarker = s.substring(to: s.index(s.startIndex, offsetBy: matches[0].rangeAt(1).location - 1)) // before "("
    let appliesToRange = NSMakeRange(matches[0].rangeAt(2).location + matches[0].rangeAt(2).length + 1, a[0])  // after ")"
    let stringAppliesTo = (s as NSString).substring(with: appliesToRange)
    let stringRemaining = s.substring(from: s.index(s.startIndex, offsetBy: appliesToRange.location + appliesToRange.length))
    let repeatedLength = m ? decompressedLengthOf(stringAppliesTo, usingDecompressedMarkers: true) : stringAppliesTo.characters.count
    return stringBeforeMarker.characters.count + (repeatedLength * a[1]) + decompressedLengthOf(stringRemaining, usingDecompressedMarkers: m)
}

func main() {
    let s = getInput().replacingOccurrences(of: "\n", with: "", options: [])
    print(decompressedLengthOf(s))
    print(decompressedLengthOf(s, usingDecompressedMarkers: true))
}

main()
