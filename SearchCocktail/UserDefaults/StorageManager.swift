//
//  Base.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.08.2021.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let defaults = UserDefaults.standard
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let archiveURL: URL
    private init() {
        archiveURL = documentDirectory.appendingPathComponent("Selected").appendingPathExtension("plist")
    }
    
    func save(contact: FavoritesCocktail) {
        var contacts = fetchContacts()
        contacts.insert(contact, at: 0)
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
    
    func fetchContacts() -> [FavoritesCocktail] {
        guard let data = try? Data(contentsOf: archiveURL) else { return [] }
        guard let cocktail = try? PropertyListDecoder().decode([FavoritesCocktail].self, from: data) else { return [] }
        return cocktail
    }
    
    func deleteContact(at index: Int) {
        var result = fetchContacts()
        result.remove(at: index)
        guard let data = try? PropertyListEncoder().encode(result) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
}
