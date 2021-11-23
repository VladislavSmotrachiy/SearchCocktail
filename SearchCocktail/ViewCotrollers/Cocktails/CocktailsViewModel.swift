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
    var headingError: Error? { get set }
    
    func checkError() -> Bool
    func fetchCocktails(completion: @escaping() -> Void)
    func numberOfRows(bool: Bool) -> Int
    func cellViewModel(at indexPath: IndexPath, bool: Bool) -> CocktailCellViewModelProtocol
    var searchName: String { get}
    func detailsViewModel(at indexPath: IndexPath, bool: Bool) -> DetailsViewModelProtocol
}

class CocktailViewModel: CocktailsViewModelProtocol {
    
    private var isStatusError = false
    var headingError: Error? = nil
    var searchName: String
    var filterDrink: [Drink] = []
    var drinks: [Drink] = []
    
    init(string: String) {
        self.searchName = string
    }
    
    func checkError() -> Bool {
        if headingError != nil {
            isStatusError = true
        }
        return isStatusError
    }
    
    func fetchCocktails(completion: @escaping() -> Void )  {
        do {
            try NetworkManager.shared.fetchData(searchName: searchName) { drink in
                switch drink {
                case .success(let drink):
                    self.isStatusError = false
                    self.drinks = drink.drinks
                case .failure(let error):
                    self.headingError = error
                    print("я тут")
                    print(self.headingError!)
                }
                completion()
            }
        } catch  {
            self.headingError = error
            print(error)
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
    
    func detailsViewModel(at indexPath: IndexPath, bool: Bool) -> DetailsViewModelProtocol {
        let drinkDetails = bool ? filterDrink[indexPath.row] : drinks[indexPath.row]
        return DetailsViewModel(drink: drinkDetails)
    }
}
