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

    init(dictionary: [String]) {
        dictionary.forEach {
            insert(word: $0)
        }
    }

    /// Insert the provided word into the tree, with each character occupying it's own `TrieNode`
    ///
    /// - Parameter word: The word to store in the `TrieTree`
    private func insert(word: String) {
        var node = root
        for character in word {
            node = node.createChildNode(for: character)
        }
        // after inserting all the characters in the word, the last node will be our leaf node (final letter in the word)
        node.isLeaf = true
    }
}
