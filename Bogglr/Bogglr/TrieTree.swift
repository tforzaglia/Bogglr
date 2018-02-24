final public class TrieTree {
    public var root = TrieNode()
    //    var visitedIndices: [BoardTile] = []

    public init() {}

    public func insert(word: String) {
        var node = root
        for character in word {
            node = node.createChildNode(for: character)
        }
        node.isLeaf = true
    }

    public func contains(word: String) -> Bool {
        var node: TrieNode? = root
        for character in word {
            node = node?.childNodes[character]
            if node == nil {
                return false
            }

        }
        return node?.isLeaf ?? false
    }

    public func isIndexInRange(row: Int, column: Int, totalRows: Int, totalColumns: Int) -> Bool {
        return row >= 0 && column >= 0 && row < totalRows && column < totalColumns
    }

    public func findValidWords(board: Board) {
        let rows = board.numberOfRows
        let columns = board.numberOfColumns

        for row in 0...rows - 1 {
            for column in 0...columns - 1 {
                let currentLetter = board.tileAtPosition(row: row, column: column)?.letter
                var string = ""

                string.append(currentLetter!)

                for child in root.childNodes where child.key == currentLetter {
                    searchForWord(root: child.value, board: board, row: row, column: column, string: string)
                }
            }
        }
    }

    let validMoves:[(x:Int,y:Int)] = [(-1,0),(-1,-1),(-1,1),(0,-1),(0,1),(1,0),(1,-1),(1,1)]
    public func searchForWord(root: TrieNode, board: Board, row: Int, column: Int, string: String) {
        // recursive base case
        if root.isLeaf {
            print(string)
        }

        let tile = board.tileAtPosition(row: row, column: column)
        tile?.isVisited = true

        for move in validMoves {
            if isIndexInRange(row: row + move.x, column: column + move.y, totalRows: board.numberOfRows, totalColumns: board.numberOfColumns),
                let tile = board.tileAtPosition(row: row + move.x, column: column + move.y), !tile.isVisited {
                var newString = string
                newString.append(tile.letter)
                for child in root.childNodes where child.key == tile.letter {
                    searchForWord(root: child.value, board: board, row: row + move.x, column: column + move.y, string: newString)
                }
            }
        }
        tile?.isVisited = false
    }

    public func printTree() {
        search(node: root)
    }

    public func search(node: TrieNode) {
        for child in node.childNodes {
            if child.value.isLeaf {
                print(child.key)
                break
            } else {
                print(child.key)
                search(node: child.value)
            }
        }
    }
}
