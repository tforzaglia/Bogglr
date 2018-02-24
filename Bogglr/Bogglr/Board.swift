final public class Board {
    let numberOfRows: Int
    let numberOfColumns: Int
    var tiles = [BoardTile]()

    public init(letters: [[Character]]) {
        self.numberOfRows = letters.count
        self.numberOfColumns = letters[0].count
        for (rowIndex, row) in letters.enumerated() {
            for (colIndex, letter) in row.enumerated() {
                tiles.append(BoardTile(row: rowIndex, column: colIndex, letter: letter))
            }
        }
    }

    public func tileAtPosition(row: Int, column: Int) -> BoardTile? {
        for tile in tiles where tile.row == row && tile.column == column {
            return tile
        }
        return nil
    }
}
