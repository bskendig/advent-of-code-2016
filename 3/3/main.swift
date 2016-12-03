//
//  main.swift
//  3
//
//  Created by Brian Kendig on 12/2/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue) as String
}

func parseLine(_ s: String) -> [Int] {
    let regex = try! NSRegularExpression(pattern: "(\\d+) +(\\d+) +(\\d+)", options: [])
    let matches = regex.matches(in: s, options: [], range: NSMakeRange(0, s.characters.count))
    var t = [0, 0, 0]
    for i in 0...2 {
        t[i] = Int((s as NSString).substring(with: matches[0].rangeAt(i + 1)))!
    }
    return t
}

func isTriangle(_ t: [Int]) -> Bool {
    let q = t.sorted()
    return q[0] + q[1] > q[2]
}

func main() {
    let text = getInput()
    let triangles = text.components(separatedBy: "\n")
    var count = 0
    for t in triangles {
        if t.isEmpty { continue }
        if isTriangle(parseLine(t)) { count += 1 }
    }
    print(count)

    count = 0
    for n in 0..<(triangles.count / 3) {
        let t1 = parseLine(triangles[n * 3])
        let t2 = parseLine(triangles[n * 3 + 1])
        let t3 = parseLine(triangles[n * 3 + 2])
        if isTriangle([t1[0], t2[0], t3[0]]) { count += 1 }
        if isTriangle([t1[1], t2[1], t3[1]]) { count += 1 }
        if isTriangle([t1[2], t2[2], t3[2]]) { count += 1 }
    }
    print(count)
}

main()
