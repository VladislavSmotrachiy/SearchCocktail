//
//  CocktailCellViewModel.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 12.10.2021.
//

import Foundation

protocol CocktailCellViewModelProtocol {
    var drinkName: String { get }
    var imageData: Data? { get }
    init(drink: Drink)
}

class CocktailCellViewModel: CocktailCellViewModelProtocol {
    var drinkName: String {
        drink.nameDrink
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: drink.images)
    }
    
    private let drink: Drink
    
    required init(drink: Drink) {
        self.drink = drink
    }
}
