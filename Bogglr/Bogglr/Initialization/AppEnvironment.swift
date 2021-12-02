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

    /// `Array` of `Character` `Array`s that will be used to construct the Boggle board
    private(set) var lettersMatrix = [[Character]]()

    /// `Array` of words that make up our dictionary
    private(set) var dictionary = [String]()

    init() {
        // build the dictionary array from the the "dictionary" text file
        readTextFile(from: "dictionary", parseClosure: { [weak self] data in
            self?.dictionary = data.components(separatedBy: .newlines)
        })

        // build the letters matrix array from the the "board" text file
        readTextFile(from: "board", parseClosure: {  [weak self]  data in
            let letters = CharacterSet.letters

            let rows = data.components(separatedBy: .newlines)
            let rowLength = rows[0].count

            // each line in the text file represents a row on the board
            for rowString in rows {
                // don't add blank lines to the array
                if rowString != "" {

                    // fail if the board input file contains rows of non equal lengths
                    if rowString.count != rowLength {
                        fatalError("All rows in the Boggle board input file must be of equal length")
                    }

                    rowString.unicodeScalars.forEach {
                        // fail if the board input file contains non letter characters
                        if !letters.contains($0) {
                            fatalError("Boggle board input file must contain only letters! Board contained an illegal \($0)")
                        }
                    }
                    // store each character of the string as a separate member of the array
                    let rowArray = rowString.compactMap { $0 }
                    self?.lettersMatrix.append(rowArray)
                }
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
