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

    /// `Array` of words that make up our dictionary
    private(set) var dictionary = [String]()

    init() {
        readTextFile(from: "dictionary")
    }

    /// Read in a dictionary from a text file stored in the app bundle
    ///
    /// - Parameters:
    ///   - resource: The name of the text file
    ///   - bundle: The bundle in which the text file lives
    private func readTextFile(from resource: String, bundle: Bundle = Bundle.main) {
        do {
            if let file =  bundle.path(forResource: resource, ofType: "txt") {
                let data = try String(contentsOfFile: file, encoding: .utf8)
                dictionary = data.components(separatedBy: .newlines)
            }
        }  catch {
            print(error)
        }
    }
}
