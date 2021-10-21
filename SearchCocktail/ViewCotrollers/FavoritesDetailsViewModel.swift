//
//  FavoritesDetailsViewModel.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 21.10.2021.
//

import Foundation

protocol FavoritesDetailsViewModelProtocol: AnyObject {
    var favorites: FavoritesCocktail {get}
    
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
    
    // MARK: Check is Favorites
    var isFavorite: Bool { get }
    var isFavoritesHeart: Bool { get}
    
    // MARK: Methods
    var viewModelDidChange: ((FavoritesDetailsViewModelProtocol) -> Void)? { get set }
    func fetchImage(image: CocktailImageView)
}

class FavoritesDetailsViewModel: FavoritesDetailsViewModelProtocol {
    var favorites: FavoritesCocktail
    
    
    required init(favorites: FavoritesCocktail) {
        self.favorites = favorites
    }
    
    var isFavoritesHeart: Bool {
        get {
            StorageManager.shared.fetchFavorites().contains(where: { favorites in
                favorites.id == favorites.id
            })
        }
    }
    
    var viewModelDidChange: ((FavoritesDetailsViewModelProtocol) -> Void)?
    
    var isFavorite: Bool {
        get {
            StorageManager.shared.fetchFavorites().isEmpty
        }
    }
    
    var secondPosition: String {
        favorites.secondPosition
    }
    
    var thridPosition: String {
        favorites.thridPosition
    }
    
    var fourthPosition: String {
        favorites.fourthPosition
    }
    
    
    var fifthPosition: String {
        favorites.fifthPosition
    }
    
    var sixthPosition: String {
        favorites.sixthPosition
    }
    
    var firstPosition: String {
        favorites.fifthPosition
    }
    
    func fetchImage(image: CocktailImageView) {
        image.fetchImage(from: favorites.images ?? "")
    }
    
    var nameCocktail: String {
        favorites.nameDrink
    }
    
    var glass: String {
        favorites.glass ?? ""
    }
    
    var instruction: String {
        favorites.instructions ?? ""
    }
    
    var ingredientFirst: String {
        favorites.ingredientFirst ?? ""
    }
    
    var ingredientSecond: String {
        favorites.ingredientSecond ?? ""
    }
    
    var ingredientThrid: String {
        favorites.ingredientThrid ?? ""
    }
    
    var ingredientFourth: String {
        favorites.ingredientFourth ?? ""
    }
    
    var ingredientFifth: String {
        favorites.ingredientFifth ?? ""
    }
    
    var ingredientSixth: String {
        favorites.ingredientSixth ?? ""
    }
}
