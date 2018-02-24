//
//  BogglrTests.swift
//  BogglrTests
//
//  Created by Thomas Forzaglia on 2/23/18.
//  Copyright © 2018 Thomas Forzaglia. All rights reserved.
//

import XCTest
@testable import Bogglr

class BogglrTests: XCTestCase {
    
    func testBoggleSolver() {
        let dictionary = ["cat", "cast", "the", "tag", "live", "cash"]
        let letters: [[Character]] = [
            ["c", "i", "z"],
            ["u", "a", "k"],
            ["q", "s", "h"],
            ["d", "t", "r"],
            ["a", "h", "y"],
            ["d", "g", "v"]
        ]

        let tree = TrieTree()
        for word in dictionary {
            tree.insert(word: word)
        }

        let board = Board(letters: letters)
        tree.findValidWords(board: board)
    }
}
