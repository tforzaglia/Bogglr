//
//  BoggleSolver.swift
//  Bogglr
//
//  Created by Thomas Forzaglia on 2/23/18.
//  Copyright © 2018 Thomas Forzaglia. All rights reserved.
//

final class BoggleSolver {

    /// The minimum amount of characters a word can have for it to be considered a valid Boggle answer
    /// Per Boggle rules https://en.wikipedia.org/wiki/Boggle, length of word should be at least 3 characters
    private let minWordLength = 3

    /// The Boggle `Board`
    private let board: Board

    /// The `TrieTree` holding the dictionary strings
    private let tree: TrieTree

    /// An `Array` of tuples representing valid moves one can make to form a word in Boggle
    /// The first `Int` (x) in the tuple represents the horizontal change from the current tile in the board
    /// The second `Int` (y) in the tuple represents the vertical change from the current tile in the board
    /// For example: (1, 0) would represent moving one space to the right from the current tile
    private let possibleBoggleMoves: [(x: Int, y: Int)] =
        [
            (-1, 0), (-1, -1), (-1 ,1),
            (0, -1), (0, 1),
            (1, 0), (1, -1), (1, 1)
        ]

    /// An `Array` of all valid words in the Boggle board
    private var validWords = [String]()

    init(board: Board, tree: TrieTree) {
        self.board = board
        self.tree = tree
    }

    /// Solve the Boggle puzzle by finding all possible words that can be formed
    ///
    /// - Returns: An `Array` of all valid words found for the Boggle board
    func findValidWords() -> [String] {
        // loop through each row and column on the board
        for tile in board.tiles {
            // call the recursive search function on the child node that matches the current tile's letter
            for child in tree.root.childNodes where child.key == tile.letter {
                searchForWord(root: child.value, tile: tile, prefix: String(describing: tile.letter))
            }
        }
        return validWords
    }

    /// Recursive search function that traverses our `TrieTree`
    /// It determines words in our dictionary that can be formed on the Boggle board
    ///
    /// - Parameters:
    ///   - root: The `TrieNode` to start our traversal from
    ///   - row: The row of the current tile
    ///   - column: The column of the current tile
    ///   - prefix: The current `String` prefix for the word we're trying to form
    private func searchForWord(root: TrieNode, tile: BoardTile, prefix: String) {
        // recursive base case - we've reached the final node
        // if the word is longer than or equal to `minWordLength`, it is valid
        if root.isLeaf && prefix.count >= minWordLength {
            validWords.append(prefix)
        }

        // set the current tile visited so we don't reuse it (which is against official Boggle rules)
        tile.isVisited = true

        // loop through the set of valid Boggle moves
        for move in possibleBoggleMoves {
            let newRow = tile.row + move.y
            let newColumn = tile.column + move.x

            // check that the next tile:
            //   is valid within the board's range,
            //   exists,
            //   has not been visited
            if board.isIndexInRange(row: newRow, column: newColumn),
                let nextTile = board.tileAtPosition(row: newRow, column: newColumn),
                !nextTile.isVisited {

                // add the next tile's letter to the existing prefix string
                var newString = prefix
                newString.append(nextTile.letter)

                // keep traversing the branch if there is a child node that contains the next tile's letter
                for child in root.childNodes where child.key == nextTile.letter {
                    searchForWord(root: child.value, tile: nextTile, prefix: newString)
                }
            }
        }

        // set the visited state back to false so that the tile can be reused for subsequent words
        tile.isVisited = false
    }
}
