//
//  main.swift
//  1
//
//  Created by Brian Kendig on 11/30/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

enum Orientation: Int {
    // clockwise
    case North = 0
    case East
    case South
    case West
}

var xPos = 0, yPos = 0
var visited: [Int : [Int : Bool]] = [0 : [0 : true]]
var foundFirstRevisit = false

func getInput() -> String {
    let bundle = Bundle.main
    let path = bundle.path(forResource: "input", ofType: "txt")
    return try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue) as String
}

func move(count: Int, mover: (Int, Int) -> (Int, Int)) {
    for _ in 1...count {
        let moved = mover(xPos, yPos)
        xPos = moved.0
        yPos = moved.1
        if foundFirstRevisit { continue }
        if visited[xPos]?[yPos] != nil {
            print("been to \(xPos), \(yPos) before")
            foundFirstRevisit = true
        } else {
            if visited[xPos] == nil { visited[xPos] = [:] }
            visited[xPos]![yPos] = true
        }
    }
}

func main() {
    let text = getInput()
    let commands = text.components(separatedBy: ", ")
    var orientation = Orientation.North
    let regex = try! NSRegularExpression(pattern: "(.)(.+)", options: [])
    for command in commands {
        let matches = regex.matches(in: command, options: [], range: NSMakeRange(0, command.characters.count))
        if !matches.isEmpty {
            let c = (command as NSString).substring(with: matches[0].rangeAt(1))
            let d = Int((command as NSString).substring(with: matches[0].rangeAt(2)))!
            let increment = (c == "R") ? 1 : 3
            orientation = Orientation(rawValue: (orientation.rawValue + increment) % 4)!
            var mover: (Int, Int) -> (Int, Int)
            switch orientation {
            case .North:
                mover = { (xPos: Int, yPos: Int) -> (Int, Int) in
                    return (xPos - 1, yPos)
                }
            case .East:
                mover = { (xPos: Int, yPos: Int) -> (Int, Int) in
                    return (xPos, yPos + 1)
                }
            case .South:
                mover = { (xPos: Int, yPos: Int) -> (Int, Int) in
                    return (xPos + 1, yPos)
                }
            case .West:
                mover = { (xPos: Int, yPos: Int) -> (Int, Int) in
                    return (xPos, yPos - 1)
                }
            }
            move(count: d, mover: mover)
        }
    }
    print("ended at \(xPos), \(yPos)")
}

main()
