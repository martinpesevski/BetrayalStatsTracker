//
//  Util.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 8/22/22.
//

import Foundation

class PersistenceManager {
    static func clearEverything() {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: "betrayal characters")
    }
    
    static func saveCharacters(_ characters: [Character]) {
        let defaults = UserDefaults.standard
        defaults.set(try? PropertyListEncoder().encode(characters), forKey: "betrayal characters")
    }
    
    static func loadCharacters() -> [Character]? {
        let defaults = UserDefaults.standard
        
        if let data = defaults.object(forKey: "betrayal characters") as? Data {
            return try? PropertyListDecoder().decode([Character].self, from: data)
        }
        
        return nil
    }
}
