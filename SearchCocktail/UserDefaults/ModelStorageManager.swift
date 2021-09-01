//
//  ModelStorageManager.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 01.09.2021.
//

import Foundation

struct FavoritesCocktail: Codable {
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
