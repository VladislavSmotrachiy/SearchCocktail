//
//  ViewModelFavorites.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 21.10.2021.
//

import Foundation
protocol FavoritesViewModelProtocol: AnyObject {
    var favorites: [FavoritesCocktail] { get }
    func fetchCourses() -> [FavoritesCocktail]
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CocktailCellViewModelProtocol
    func detailsViewModel(at indexPath: IndexPath) -> FavoritesDetailsViewModel
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    func fetchCourses() -> [FavoritesCocktail] {
       favorites =  StorageManager.shared.fetchFavorites()
    }
    
    
    func detailsViewModel(at indexPath: IndexPath) -> FavoritesDetailsViewModel {
        let drinkDetails =  fetchCourses()[indexPath.row]
        return FavoritesDetailsViewModel(favorites: drinkDetails)
    }
    
    var favorites: [FavoritesCocktail] = []

    
    
    func numberOfRows() -> Int {
        fetchCourses().count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CocktailCellViewModelProtocol {
        let course =  fetchCourses()[indexPath.row]
        return CocktailCellViewModel(drink: course)
    }
    
}
