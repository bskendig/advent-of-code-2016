//
//  main.swift
//  2
//
//  Created by Brian Kendig on 12/2/16.
//  Copyright © 2016 Brian Kendig. All rights reserved.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue) as String
}

func findCode(with instructions: [String], startingAt: (Int, Int), for keypad: [[String]]) -> String {
    var code: [String] = []
    var xPos = startingAt.0, yPos = startingAt.1
    for line in instructions {
        if line.isEmpty { continue }
        for c in line.characters {
            switch c {
            case "U": if keypad[xPos][yPos-1] != " " { yPos -= 1 }
            case "D": if keypad[xPos][yPos+1] != " " { yPos += 1 }
            case "L": if keypad[xPos-1][yPos] != " " { xPos -= 1 }
            case "R": if keypad[xPos+1][yPos] != " " { xPos += 1 }
            default: break
            }
        }
        code.append(keypad[yPos][xPos])
    }
    return code.joined()
}

func main() {
    let text = getInput()
    let instructions = text.components(separatedBy: "\n")
    print(findCode(with: instructions, startingAt: (2, 2), for: [
        [" ", " ", " ", " ", " "],
        [" ", "1", "2", "3", " "],
        [" ", "4", "5", "6", " "],
        [" ", "7", "8", "9", " "],
        [" ", " ", " ", " ", " "]]))
    print(findCode(with: instructions, startingAt: (1, 3), for: [
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", "1", " ", " ", " "],
        [" ", " ", "2", "3", "4", " ", " "],
        [" ", "5", "6", "7", "8", "9", " "],
        [" ", " ", "A", "B", "C", " ", " "],
        [" ", " ", " ", "D", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "]]))
}

main()
