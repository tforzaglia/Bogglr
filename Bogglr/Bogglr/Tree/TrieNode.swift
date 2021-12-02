//
//  TrieNode.swift
//  Bogglr
//
//  Created by Thomas Forzaglia on 2/23/18.
//  Copyright © 2018 Thomas Forzaglia. All rights reserved.
//

/// Represents a node in our `TrieTree`
final class TrieNode {
    /// The child nodes of this node
    private(set) var childNodes = [Character: TrieNode]()

    /// Whether or not this node is the end of a word
    var isLeaf = false

    /// Adds a child node for the given character if one doesn't already exist
    ///
    /// - Parameter character: The letter being added as a child
    /// - Returns: If a `TrieNode` doesn't exist for the given character, a new `TrieNode` created and returned.
    ///            Otherwise, the already created  `TrieNode` is returned
    func createChildNode(for character: Character) -> TrieNode {
        // if we already have a child node created for this character, just return it
        if let child = childNodes[character] {
            return child
        }
        // no node exists, create a new one
        else {
            let node = TrieNode()
            childNodes[character] = node

            return node
        }
    }
}
