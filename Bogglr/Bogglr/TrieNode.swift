final public class TrieNode {
    // the child nodes of this node
    public var childNodes = [Character: TrieNode]()

    // boolean indicating whether or not this node is the end of a word
    public var isLeaf: Bool

    public var isVisited: Bool

    public init() {
        isLeaf = false
        isVisited = false
    }

    public func createChildNode(for character: Character) -> TrieNode {
        if let child = childNodes[character] {
            return child
        } else {
            let node = TrieNode()
            childNodes[character] = node

            return node
        }
    }
}
