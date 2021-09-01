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
        archiveURL = documentDirectory.appendingPathComponent("Contacts").appendingPathExtension("plist")
    }
    
    var selected: [FavoritesCocktail] {
        
        get {
            guard let data = defaults.value(forKey: "selected") as? Data  else { return [] }
            guard let cocktail = try? PropertyListDecoder().decode([FavoritesCocktail].self, from: data)
            else {return []}
            return cocktail
        }
        
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return}
            defaults.set(data, forKey: "selected")
        }
    }
    
    func saveFavorites(nameDrink: String?, drinkAlternate: String?,
                       tags: String?, video: String?, category: String?,
                       IBA: String?, alcoholic: String?, glass: String?,
                       instructions: String?, images: String?,
                       dateModified: String?) {
        
        let favorites = FavoritesCocktail( nameDrink: nameDrink ?? "",
                                           drinkAlternate: drinkAlternate ?? "" ,
                                           tags: tags ?? "",
                                           video: video ?? "",
                                           category: category ?? "",
                                           IBA: IBA ?? "",
                                           alcoholic: alcoholic ?? "",
                                           glass: glass ?? "",
                                           instructions: instructions ?? "",
                                           images: images ?? "",
                                           dateModified: dateModified ?? "")
        
        selected.append(favorites)
    }
    
    func deleteContact(at index: Int) {
        var contacts = selected
            contacts.remove(at: index)
            guard let data = try? PropertyListEncoder().encode(contacts) else { return }
            try? data.write(to: archiveURL, options: .noFileProtection)
    }
}
