//
//  DetailsViewModel.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 15.10.2021.
//

import Foundation

protocol DetailsViewModelProtocol: AnyObject {
    var favoritesCocktail: FavoritesCocktail {get}
    var drink: Drink {get}
    
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
    var viewModelDidChange: ((DetailsViewModelProtocol) -> Void)? { get set }
    func fetchImage(image: CocktailImageView)
    func favoriteButtonPressed()
}

class DetailsViewModel: DetailsViewModelProtocol {
    var drink: Drink
    
    var favoritesCocktail: FavoritesCocktail {
        FavoritesCocktail.init(
            id: drink.id ?? "",
            nameDrink: drink.nameDrink,
            drinkAlternate: drink.drinkAlternate ?? "",
            tags: drink.tags ?? "",
            video: drink.video ?? "",
            category: drink.category ?? "",
            IBA: drink.IBA ?? "",
            alcoholic: drink.alcoholic ?? "",
            glass: drink.glass ?? "",
            instructions: drink.instructions ?? "",
            images: drink.images ?? "",
            ingredientFirst: drink.ingredientFirst ?? "",
            ingredientSecond: drink.ingredientSecond ?? "",
            ingredientThrid: drink.ingredientThrid ?? "",
            ingredientFourth: drink.ingredientFourth ?? "",
            ingredientFifth: drink.ingredientFifth ?? "",
            ingredientSixth: drink.ingredientSixth ?? "",
            proportionFirst: drink.proportionFirst ?? "",
            proportionSecond: drink.proportionSecond ?? "",
            proportionThrid: drink.proportionThrid ?? "",
            proportionFourth: drink.proportionFourth ?? "",
            proportionFifth: drink.proportionFifth ?? "",
            proportionSixth: drink.proportionSixth ?? "",
            dateModified: drink.dateModified ?? ""
        )
    }
    
    required init(drink: Drink) {
        self.drink = drink
    }
    
    var isFavoritesHeart: Bool {
        get {
            StorageManager.shared.fetchFavorites().contains(where: { favorites in
                favorites.id == drink.id
            })
        }
    }
    
    var viewModelDidChange: ((DetailsViewModelProtocol) -> Void)?
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }
    
    var isFavorite: Bool {
        get {
            StorageManager.shared.fetchFavorites().isEmpty
        } set {
            setFavorites()
        }
    }
    
    private func setFavorites(){
        if !StorageManager.shared.fetchFavorites().contains(where: { favorites in
            favoritesCocktail.id == favorites.id
        }) {
            StorageManager.shared.save(contact: favoritesCocktail)
            viewModelDidChange?(self)
        }
    }
    
    var secondPosition: String {
        drink.secondPosition
    }
    
    var thridPosition: String {
        drink.thridPosition
    }
    
    var fourthPosition: String {
        drink.fourthPosition
    }
    
    
    var fifthPosition: String {
        drink.fifthPosition
    }
    
    var sixthPosition: String {
        drink.sixthPosition
    }
    
    var firstPosition: String {
        drink.fifthPosition
    }
    
    func fetchImage(image: CocktailImageView) {
        image.fetchImage(from: drink.images ?? "")
    }
    
    var nameCocktail: String {
        drink.nameDrink
    }
    
    var glass: String {
        drink.glass ?? ""
    }
    
    var instruction: String {
        drink.instructions ?? ""
    }
    
    var ingredientFirst: String {
        drink.ingredientFirst ?? ""
    }
    
    var ingredientSecond: String {
        drink.ingredientSecond ?? ""
    }
    
    var ingredientThrid: String {
        drink.ingredientThrid ?? ""
    }
    
    var ingredientFourth: String {
        drink.ingredientFourth ?? ""
    }
    
    var ingredientFifth: String {
        drink.ingredientFifth ?? ""
    }
    
    var ingredientSixth: String {
        drink.ingredientSixth ?? ""
    }
}

