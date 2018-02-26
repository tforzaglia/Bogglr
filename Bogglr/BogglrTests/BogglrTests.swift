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
        let tree = TrieTree(dictionary: AppEnvironment.shared.dictionary)
        let board = Board(letters: AppEnvironment.shared.lettersMatrix)
        let solver = BoggleSolver(board: board, tree: tree)
        let validWords = solver.findValidWords()

        print("Here are the valid Boggle words in the board")
        print("********************************************")
        validWords.forEach { print($0) }
        print("********************************************")
    }
}
