//
//  AppEnvironment.swift
//  Bogglr
//
//  Created by Thomas Forzaglia on 2/24/18.
//  Copyright © 2018 Thomas Forzaglia. All rights reserved.
//

import Foundation

/// Singleton initialized on app launch
final class AppEnvironment {
    static var shared: AppEnvironment!

    /// The `TrieTree` data structure that will hold the dictionary values
    let tree = TrieTree()

    /// `Array` of `Character` `Array`s that will be used to construct the Boggle board
    private(set) var lettersMatrix = [[Character]]()

    /// `Array` of words that make up our dictionary
    private var dictionary = [String]()

    init() {
        // build the dictionary array from the the "dictionary" text file
        readTextFile(from: "dictionary", parseClosure: { [weak self] data in
            self?.dictionary = data.components(separatedBy: .newlines)
            self?.dictionary.forEach {
                tree.insert(word: $0)
            }
        })

        // build the letters matrix array from the the "board" text file
        readTextFile(from: "board", parseClosure: {  [weak self]  data in
            // each line in the text file represents a row on the board
            for rowString in data.components(separatedBy: .newlines) {
                // store each character of the string as a separate member of the array
                let rowArray = rowString.flatMap { $0 }
                self?.lettersMatrix.append(rowArray)
            }
        })
    }

    /// Read from a text file stored in the app bundle
    ///
    /// - Parameters:
    ///   - resource: The name of the text file
    ///   - bundle: The bundle in which the text file lives
    ///   - parseClosure: The closure to run on the text file contents
    private func readTextFile(from resource: String, bundle: Bundle = Bundle.main, parseClosure: (String) -> Void) {
        do {
            if let file =  bundle.path(forResource: resource, ofType: "txt") {
                let data = try String(contentsOfFile: file, encoding: .utf8)
                parseClosure(data)
            }
        }  catch {
            print(error)
        }
    }
}
