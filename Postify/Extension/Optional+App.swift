//
//  OptionalUnwrapped.swift
//  Postify
//
//  Created by Nagaraj Rao on 25/05/24.
//

import Foundation
extension Optional<String> {
    func unwrapped(defaultValue: String = "") -> String {
        self ?? defaultValue
    }
    
    func removingNewlines(defaultValue: String = "") -> String {
        let newlineCharacters = CharacterSet.newlines
        let components = self?.components(separatedBy: newlineCharacters)
        return components?.joined() ?? ""
    }
}
