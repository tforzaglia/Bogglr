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
        let env = AppEnvironment()
        let tree = TrieTree(dictionary: env.dictionary)
        let board = Board(letters: env.lettersMatrix)
        let solver = BoggleSolver(board: board, tree: tree)
        let validWords = solver.findValidWords()

        print("\nHere are the valid Boggle words in the board")
        print("********************************************\n")
        validWords.forEach { print($0) }
        print("\nnumber of valid words = \(validWords.count)")
        print("********************************************\n")
    }
}
