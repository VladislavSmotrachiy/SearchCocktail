//
//  Cocktail.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 22.07.2021.
//

import Foundation



//struct Cocktail: Codable {
//    let drinks: [Drinks]
//}
//
//struct Drinks: Codable {
//
//    let dateModified: String?
//    let idDrink: String?
//    let strAlcoholic: String?
//    let strCategory: String?
//    let strCreativeCommonsConfirmed: String?
//    let strDrink: String
//    let strDrinkAlternate: String?
//    let strDrinkThumb: String?
//    let strGlass: String?
//    let strImageAttribution: String?
//    let strImageSource: String?
//
//
//}


struct Cocktail: Decodable{
    let drinks: [Drinks]
}

struct Drinks: Decodable {
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
    let instructionsES: String?
    let instructionsDE: String?
    let instructionsFR: String?
    let instructionsIT: String?
    let instructionsZHHANS: String?
    let instructionsZHHANT: String?
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
        case instructionsES = "strInstructionsES"
        case instructionsDE = "strInstructionsDE"
        case instructionsFR = "strInstructionsFR"
        case instructionsIT = "strInstructionsIT"
        case instructionsZHHANS = "strInstructionsZHHANS"
        case instructionsZHHANT = "strInstructionsZHHANT"
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


enum URLexemples: String {
    case url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
}


