//
//  Base.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.08.2021.
//

import Foundation

class Base {

    let defaults = UserDefaults.standard
    
    static let shared = Base()
    
    struct FavoritesCocktail: Codable {
    let id: String?
    let nameDrink: String
    let drinkAlternate: String?
    let tags: String?
    let video: String?
    let category: String?
    let IBA: String?
    let alcoholic: String?
    let glass: String?
    let instructions: String?
    let images: String?
    let dateModified: String?
    }
    
    var selected: [FavoritesCocktail] {
        
        get {
            if let data = defaults.value(forKey: "selected") as? Data {
             return try! PropertyListDecoder().decode([FavoritesCocktail].self, from: data)
            } else {
                return [FavoritesCocktail]()
            }
        }
         
        set {
            if let data = try? PropertyListEncoder().encode(newValue){
                defaults.set(data, forKey: "selected")
            }
        }
    }
    
    func saveFavorites(id: String?, nameDrink: String?, drinkAlternate: String?,
                       tags: String?, video: String?, category: String?,
                       IBA: String?, alcoholic: String?, glass: String?,
                       instructions: String?, images: String?,
                       dateModified: String?) {
        
        let favorites = FavoritesCocktail(id: id, nameDrink: nameDrink ?? "", drinkAlternate: drinkAlternate ?? "" , tags: tags ?? "", video: video ?? "", category: category ?? "", IBA: IBA ?? "", alcoholic: alcoholic ?? "", glass: glass ?? "", instructions: instructions ?? "", images: images ?? "", dateModified: dateModified ?? "")
        
        selected.append(favorites)
    }

}
