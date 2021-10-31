//
//  FavoritesDetailsViewModel.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 21.10.2021.
//

import Foundation

protocol FavoritesDetailsViewModelProtocol: AnyObject {
    
    init(favorites: FavoritesCocktail)
    
    // MARK: Lables
    var nameCocktail: String { get }
    var glass: String { get }
    var instruction: String { get }
    var ingredientFirst: String { get }
    var ingredientSecond: String { get }
    var ingredientThrid: String { get }
    var ingredientFourth: String { get }
    var ingredientFifth: String { get }
    var ingredientSixth: String { get }
    var firstPosition: String {get}
    var secondPosition: String {get}
    var thridPosition: String {get}
    var fourthPosition: String {get}
    var fifthPosition: String {get}
    var sixthPosition: String {get}
    
    
    // MARK: Methods
    func fetchImage(image: CocktailImageView)
}

class FavoritesDetailsViewModel: FavoritesDetailsViewModelProtocol {

  private let favoritess: FavoritesCocktail
    
    required init(favorites: FavoritesCocktail) {
        self.favoritess = favorites
    }
    
    var secondPosition: String {
        favoritess.secondPosition
    }
    
    var thridPosition: String {
        favoritess.thridPosition
    }
    
    var fourthPosition: String {
        favoritess.fourthPosition
    }
    
    var fifthPosition: String {
        favoritess.fifthPosition
    }
    
    var sixthPosition: String {
        favoritess.sixthPosition
    }
    
    var firstPosition: String {
        favoritess.firstPosition
    }
    
    func fetchImage(image: CocktailImageView) {
        image.fetchImage(from: favoritess.images ?? "")
    }
    
    var nameCocktail: String {
        favoritess.nameDrink ?? ""
    }
    
    var glass: String {
        favoritess.glass ?? ""
    }
    
    var instruction: String {
        favoritess.instructions ?? ""
    }
    
    var ingredientFirst: String {
        favoritess.ingredientFirst ?? ""
    }
    
    var ingredientSecond: String {
        favoritess.ingredientSecond ?? ""
    }
    
    var ingredientThrid: String {
        favoritess.ingredientThrid ?? ""
    }
    
    var ingredientFourth: String {
        favoritess.ingredientFourth ?? ""
    }
    
    var ingredientFifth: String {
        favoritess.ingredientFifth ?? ""
    }
    
    var ingredientSixth: String {
        favoritess.ingredientSixth ?? ""
    }
}
