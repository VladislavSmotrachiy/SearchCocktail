//
//  CocktailCellViewModel.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 12.10.2021.
//

import Foundation

protocol CocktailCellViewModelProtocol {
    var drinkName: String { get }
    var drink: Drink {get}
    func fetchImage(image: CocktailImageView)
   
}

class CocktailCellViewModel: CocktailCellViewModelProtocol {
    func fetchImage(image: CocktailImageView) {
        image.fetchImage(from: drink.images ?? "")
    }
    var drink: Drink
    init(drink: Drink){
        self.drink = drink
    }
        
    var drinkName: String {
        drink.nameDrink
    }
    

    
}
