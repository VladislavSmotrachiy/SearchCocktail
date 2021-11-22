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

    func errors() -> Error?
    func checkError() -> Bool
    func fetchCourses(completion: @escaping() -> Void)
    func numberOfRows(bool: Bool) -> Int
    func cellViewModel(at indexPath: IndexPath, bool: Bool) -> CocktailCellViewModelProtocol
    var searchName: String { get}
    func detailsViewModel(at indexPath: IndexPath, bool: Bool) -> DetailsViewModelProtocol
}

class CocktailViewModel: CocktailsViewModelProtocol {
    
    var headlingError: Error? = nil
    var bool = false
    
    func checkError() -> Bool {
        if headlingError != nil {
            bool = true
        }
        return bool
    }
        
    func errors() -> Error?  {
        headlingError
    }

    func detailsViewModel(at indexPath: IndexPath, bool: Bool) -> DetailsViewModelProtocol {
        let drinkDetails = bool ? filterDrink[indexPath.row] : drinks[indexPath.row]
        return DetailsViewModel(drink: drinkDetails)
    }
    var searchName: String
    var filterDrink: [Drink] = []
    var drinks: [Drink] = []
    
    init(string: String) {
        self.searchName = string
    }
    
    func fetchCourses(completion: @escaping() -> Void)  {
        do {
            try NetworkManager.shared.fetchData(string: searchName) { drink in
                switch drink {
                case .success(let drink):
                    self.bool = false
                    self.drinks = drink.drinks
                case .failure(let error):
                    switch error {
                    default:
                        self.headlingError = error
                    }
                    
                    print("я тут")
                    print(self.headlingError!)
                }
            }
        } catch  {
            self.headlingError = error
            print(error)
//            print("я тут")
        }
        completion()
    }
 
    func numberOfRows(bool: Bool) -> Int {
        bool ? filterDrink.count : drinks.count
    }
    
    func cellViewModel(at indexPath: IndexPath, bool: Bool) -> CocktailCellViewModelProtocol {
        let course = bool ? filterDrink[indexPath.row] : drinks[indexPath.row]
        return CocktailCellViewModel(drink: course)
    }
}
