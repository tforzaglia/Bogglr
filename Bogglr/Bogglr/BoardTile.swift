final public class BoardTile {
    public let row: Int
    public let column: Int
    public let letter: Character
    public var isVisited = false

    public init(row: Int, column: Int, letter: Character) {
        self.row = row
        self.column = column
        self.letter = letter
    }
}
