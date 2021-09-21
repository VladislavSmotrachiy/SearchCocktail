//
//  ModelStorageManager.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 01.09.2021.
//

import Foundation

struct FavoritesCocktail: Codable {
    let id: String?
    let nameDrink: String?
    let drinkAlternate: String?
    let tags: String?
    let video: String?
    let category: String?
    let IBA: String?
    let alcoholic: String?
    let glass: String?
    let instructions: String?
    let images: String?
    let ingredientFirst: String?
    let ingredientSecond: String?
    let ingredientThrid: String?
    let ingredientFourth: String?
    let ingredientFifth: String?
    let ingredientSixth: String?
    let proportionFirst: String?
    let proportionSecond: String?
    let proportionThrid: String?
    let proportionFourth: String?
    let proportionFifth: String?
    let proportionSixth: String?
    let dateModified: String?
    
    var firstPosition: String {
   " \(ingredientFirst ?? ""): \(proportionFirst ?? "")"
    }
    var secondPosition: String {
   " \(ingredientSecond ?? ""): \(proportionSecond ?? "")"
    }
    var thridPosition: String {
   " \(ingredientThrid ?? "its all"): \(proportionThrid ?? "its all")"
    }
    var fourthPosition: String {
        " \(ingredientFourth ?? "its all"): \(proportionFourth ?? "its all")"
    }
    var fifthPosition: String {
   " \(ingredientFifth ?? "its all"): \(proportionFifth ?? "its all")"
    }
    var sixthPosition: String {
   " \(ingredientSixth ?? "its all"): \(proportionSixth ?? "its all")"
    }
}
