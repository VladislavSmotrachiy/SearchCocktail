//
//  CocktailsViewModel.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 12.10.2021.
//

import Foundation

protocol CocktailsViewModelProtocol: AnyObject {
    var drinks: [Drink] { get }
    var filterDrink: [Drink] {get set}
    func fetchCourses(completion: @escaping() -> Void)
    func numberOfRows(bool: Bool) -> Int
    func cellViewModel(at indexPath: IndexPath, bool: Bool) -> CocktailCellViewModelProtocol
    var string: String { get}
    func detailsViewModel(at indexPath: IndexPath, bool: Bool) -> DetailsViewModelProtocol
}

class CocktailViewModel: CocktailsViewModelProtocol {
 
    func detailsViewModel(at indexPath: IndexPath, bool: Bool) -> DetailsViewModelProtocol {
        let drinkDetails = bool ? filterDrink[indexPath.row] : drinks[indexPath.row]
        return DetailsViewModel(drink: drinkDetails)
    }
    
    var string: String
    var filterDrink: [Drink] = []
    var drinks: [Drink] = []
    
    init(string: String) {
        self.string = string
    }
 
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(string: string) { drink in
            self.drinks = drink.drinks
            completion()
        }
    }
    
    func numberOfRows(bool: Bool) -> Int {
        bool ? filterDrink.count : drinks.count
    }
    
    func cellViewModel(at indexPath: IndexPath, bool: Bool) -> CocktailCellViewModelProtocol {
        let course = bool ? filterDrink[indexPath.row] : drinks[indexPath.row]
        return CocktailCellViewModel(drink: course)
    }
    
}
