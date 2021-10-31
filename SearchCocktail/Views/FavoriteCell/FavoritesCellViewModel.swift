//
//  FavoritesCellViewModel.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 27.10.2021.
//

import Foundation
protocol FavoritesCellViewModelProtocol {
    
    var drinkName: String { get }
    var drink: FavoritesCocktail {get}
    func fetchImage(image: CocktailImageView)
}

class FavoritesCellViewModel: FavoritesCellViewModelProtocol {
    func fetchImage(image: CocktailImageView) {
        image.fetchImage(from: drink.images ?? "")
    }
    
    var drink: FavoritesCocktail
    
    init(drink: FavoritesCocktail){
        self.drink = drink
    }
    
    var drinkName: String {
        drink.nameDrink ?? ""
    }
}
