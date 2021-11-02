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
    func numberOfRows() -> Int
    func numberOfRowsFilter() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CocktailCellViewModelProtocol
    func cellViewModelFilter(at indexPath: IndexPath) -> CocktailCellViewModelProtocol
    var string: String { get}
    func detailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol
    func detailsViewModelFilter(at indexPath: IndexPath) -> DetailsViewModelProtocol
}

class CocktailViewModel: CocktailsViewModelProtocol {
    func detailsViewModelFilter(at indexPath: IndexPath) -> DetailsViewModelProtocol {
        let drinkDetails =  filterDrink[indexPath.row]
        return DetailsViewModel(drink: drinkDetails)
    }
    
    
    func detailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol {
        let drinkDetails =  drinks[indexPath.row]
        return DetailsViewModel(drink: drinkDetails)
    }
    
    var string: String
    var filterDrink: [Drink] = []
    var drinks: [Drink] = []
    
    init(string: String) {
        self.string = string
    }
    
    func numberOfRowsFilter() -> Int {
        filterDrink.count
    }
    
    func cellViewModelFilter(at indexPath: IndexPath) -> CocktailCellViewModelProtocol {
        let course =  filterDrink[indexPath.row]
        return CocktailCellViewModel(drink: course)
    }
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(string: string) { drink in
            self.drinks = drink.drinks
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        drinks.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CocktailCellViewModelProtocol {
        let course =  drinks[indexPath.row]
        return CocktailCellViewModel(drink: course)
    }
    
}
