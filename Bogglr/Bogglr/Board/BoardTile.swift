//
//  BoardTile.swift
//  Bogglr
//
//  Created by Thomas Forzaglia on 2/23/18.
//  Copyright © 2018 Thomas Forzaglia. All rights reserved.
//

/// Represents a single tile in the Boggle board
final class BoardTile {
    /// The row of the tile
    let row: Int

    /// The column of the tile
    let column: Int

    /// The letter value for the tile
    let letter: Character

    /// Whether or not we have traversed this tile during our recursive algorithm execution
    var isVisited = false

    init(row: Int, column: Int, letter: Character) {
        self.row = row
        self.column = column
        self.letter = letter
    }
}
