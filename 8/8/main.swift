//
//  main.swift
//  8
//
//  Created by Brian Kendig on 12/8/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue) as String
}

let width = 50, height = 6
var pixels: [[Bool]] = Array(repeating: Array(repeating: false, count: width), count: height)

func makeRect(width: Int, height: Int) {
    for y in 0..<height {
        for x in 0..<width {
            pixels[y][x] = true
        }
    }
}

func rotateRow(y: Int, by: Int) {
    var row: [Bool] = Array(repeating: false, count: width)
    for x in 0..<width {
        let offset = (x + by) % width
        row[offset] = pixels[y][x]
    }
    for x in 0..<width {
        pixels[y][x] = row[x]
    }
}

func rotateColumn(x: Int, by: Int) {
    var column: [Bool] = Array(repeating: false, count: height)
    for y in 0..<height {
        let offset = (y + by) % height
        column[offset] = pixels[y][x]
    }
    for y in 0..<height {
        pixels[y][x] = column[y]
    }
}

func count() -> Int {
    let countRow = { (row: [Bool]) -> Int in row.map({ $0 ? 1 : 0 }).reduce(0, +) }
    return pixels.map({ countRow($0) }).reduce(0, +)
}

func display() {
    for y in 0..<height {
        print(pixels[y].map({ $0 ? "#" : "." }).joined())
    }
}

// map the string matches to an array of two integers
func match(_ s: String, regex: NSRegularExpression) -> [Int]? {
    let matches = regex.matches(in: s, options: [], range: NSMakeRange(0, s.characters.count))
    if matches.isEmpty { return nil }
    else { return (1...2).map { Int((s as NSString).substring(with: matches[0].rangeAt($0)))! } }
}

func main() {
    let operations = getInput().components(separatedBy: "\n")
    let rectRE = try! NSRegularExpression(pattern: "^rect (\\d+)x(\\d+)$", options: [])
    let colRE  = try! NSRegularExpression(pattern: "^rotate column x=(\\d+) by (\\d+)$", options: [])
    let rowRE  = try! NSRegularExpression(pattern: "^rotate row y=(\\d+) by (\\d+)$", options: [])
    for op in operations {
        if let a = match(op, regex: rectRE) {
            makeRect(width: Int(a[0]), height: Int(a[1]))
            continue
        }
        if let a = match(op, regex: rowRE) {
            rotateRow(y: Int(a[0]), by: Int(a[1]))
            continue
        }
        if let a = match(op, regex: colRE) {
            rotateColumn(x: Int(a[0]), by: Int(a[1]))
            continue
        }
    }
    print("\(count()) pixels are lit.")
    display()
}

main()
