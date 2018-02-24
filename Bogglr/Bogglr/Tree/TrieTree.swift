//
//  TrieTree.swift
//  Bogglr
//
//  Created by Thomas Forzaglia on 2/23/18.
//  Copyright © 2018 Thomas Forzaglia. All rights reserved.
//

/// The tree data structure in which we store our dictionary values
final class TrieTree {
    /// The root node of the `TrieTree`
    var root = TrieNode()

    /// An `Array` of tuples representing valid moves one can make to form a word in Boggle
    /// The first `Int` (x) in the tuple represents the vertical change from the current tile in the board
    /// The second `Int` (y) in the tuple represents the horizontal change from the current tile in the board
    /// For example: (0, 1) would represent moving one space to the right from the current tile
    let validBoggleMoves:[(x: Int, y: Int)] = [(-1, 0), (-1, -1), (-1 ,1), (0, -1), (0, 1), (1, 0), (1, -1), (1, 1)]

    /// Insert the provided word into the tree, with each character occupying it's own `TrieNode`
    ///
    /// - Parameter word: The word to store in the `TrieTree`
    func insert(word: String) {
        var node = root
        for character in word {
            node = node.createChildNode(for: character)
        }
        // after inserting all the characters in the word, the last node will be our leaf node (final letter in the word)
        node.isLeaf = true
    }

    /// This function is used to ensure that we don't try to access an index that doesn't exist in our board
    ///
    /// - Parameters:
    ///   - row: The row that we want to access in the board
    ///   - column: The column that we want to access in the board
    ///   - totalRows: The total number of rows in the board
    ///   - totalColumns: The total number of columns in the board
    /// - Returns: True if the desired row and column exists in our board
    ///            False if the desired row and column are out of bounds
    func isIndexInRange(row: Int, column: Int, totalRows: Int, totalColumns: Int) -> Bool {
        return row >= 0 && column >= 0 && row < totalRows && column < totalColumns
    }

    /// Solve the Boggle puzzle by finding all possible words that can be formed
    ///
    /// - Parameter board: The Boggle `Board`
    func findValidWords(board: Board) {
        // loop through each row and column on the board
        for row in 0...board.numberOfRows - 1 {
            for column in 0...board.numberOfColumns - 1 {

                // ensure that the tile at the current row and column has an associated letter
                guard let currentLetter = board.tileAtPosition(row: row, column: column)?.letter else { return }

                // call the recursive search function on the child node that matches the current tile's letter
                for child in root.childNodes where child.key == currentLetter {
                    searchForWord(root: child.value, board: board, row: row, column: column, prefix: String(describing: currentLetter))
                }
            }
        }
    }

    /// Recursive search function that traverses our `TrieTree`
    /// It prints out words in our dictionary that can be formed on the Boggle board
    ///
    /// - Parameters:
    ///   - root: The `TrieNode` to start our traversal from
    ///   - board: The Boggle board
    ///   - row: The row of the current tile
    ///   - column: The column of the current tile
    ///   - prefix: The current `String` prefix for the word we're trying to form
    private func searchForWord(root: TrieNode, board: Board, row: Int, column: Int, prefix: String) {
        // recursive base case - we've reached the final node
        if root.isLeaf {
            print(prefix)
        }

        // set the current tile visited so we don't reuse it (which is against official Boggle rules)
        let currentTile = board.tileAtPosition(row: row, column: column)
        currentTile?.isVisited = true

        // loop through the set of valid Boggle moves
        for move in validBoggleMoves {
            let newRow = row + move.x
            let newColumn = row + move.y

            // check that the next tile:
            //   is valid within the board's range,
            //   exists,
            //   has not been visited
            if isIndexInRange(row: newRow, column: newColumn, totalRows: board.numberOfRows, totalColumns: board.numberOfColumns),
                let nextTile = board.tileAtPosition(row: newRow, column: newColumn),
                !nextTile.isVisited {

                // add the next tile's letter to the existing prefix string
                var newString = prefix
                newString.append(nextTile.letter)

                // keep traversing the branch if there is a child node that contains the next tile's letter
                for child in root.childNodes where child.key == nextTile.letter {
                    searchForWord(root: child.value, board: board, row: row + move.x, column: column + move.y, prefix: newString)
                }
            }
        }
v
        // set the visited state back to false so that the tile can be reused for subsequent words
        currentTile?.isVisited = false
    }
}
