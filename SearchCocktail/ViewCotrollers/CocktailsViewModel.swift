//
//  CocktailsViewModel.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 12.10.2021.
//

import Foundation

protocol CocktailsViewModelProtocol: AnyObject {
    var drinks: [Drink] { get }
    func fetchCourses(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CocktailCellViewModelProtocol
    init(api: String)
//    func detailsViewModel(at indexPath: IndexPath) -> CourseDetailsViewModelProtocol
}

class CocktailViewModel: CocktailsViewModelProtocol {
    
    var cocktailNameForSearch: String
    required init(api: String) {
        self.cocktailNameForSearch = api
    }
    
    var drinks: [Drink] = []
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(string: cocktailNameForSearch) { drink in
            self.drinks = drink.drinks
            
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        drinks.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CocktailCellViewModelProtocol {
        let course = drinks[indexPath.row]
        return CocktailCellViewModel(drink: course)
    }
    
//    func detailsViewModel(at indexPath: IndexPath) -> CourseDetailsViewModelProtocol {
//        let course = courses[indexPath.row]
//        return CourseDetailsViewModel(course: course)
//    }
}
