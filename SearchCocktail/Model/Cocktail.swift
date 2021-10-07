//
//  Cocktail.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 22.07.2021.
//

import Foundation

struct Cocktail: Decodable{
    let drinks: [Drink]
}

struct Drink:  Decodable {
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

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case nameDrink = "strDrink"
        case drinkAlternate = "strDrinkAlternate"
        case tags = "strTags"
        case video = "strVideo"
        case category = "strCategory"
        case IBA = "strIBA"
        case alcoholic = "strAlcoholic"
        case glass = "strGlass"
        case instructions = "strInstructions"
        case images = "strDrinkThumb"
        case ingredientFirst = "strIngredient1"
        case ingredientSecond = "strIngredient2"
        case ingredientThrid = "strIngredient3"
        case ingredientFourth = "strIngredient4"
        case ingredientFifth = "strIngredient5"
        case ingredientSixth = "strIngredient6"
        case proportionFirst = "strMeasure1"
        case proportionSecond = "strMeasure2"
        case proportionThrid = "strMeasure3"
        case proportionFourth = "strMeasure4"
        case proportionFifth = "strMeasure5"
        case proportionSixth = "strMeasure6"
        case dateModified = "dateModified"
    }
}


