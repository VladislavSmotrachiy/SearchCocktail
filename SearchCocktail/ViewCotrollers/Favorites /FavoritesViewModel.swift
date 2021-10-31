//
//  ViewModelFavorites.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 21.10.2021.
//

import Foundation

protocol FavoritesViewModelProtocol: AnyObject {
    var favorites: [FavoritesCocktail] { get set }
    
    func numberOfRows() -> Int
    func delite(int: Int)
    func cellViewModel(at indexPath: IndexPath) -> FavoritesCellViewModelProtocol
    func detailsViewModel(at indexPath: IndexPath) -> FavoritesDetailsViewModelProtocol
    func delitFavorites(indexPath: IndexPath)
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    
    func delite(int: Int) {
        favorites.remove(at: int)
    }
    
    func delitFavorites(indexPath: IndexPath) {
        StorageManager.shared.deleteFavorites(at: indexPath.row)
    }
    
    func detailsViewModel(at indexPath: IndexPath) -> FavoritesDetailsViewModelProtocol {
        let drinkDetails =  favorites[indexPath.row]
        return FavoritesDetailsViewModel(favorites: drinkDetails)
    }
    
    var favorites: [FavoritesCocktail] {
        get {
            StorageManager.shared.fetchFavorites()
        } set {
        }
    }
    
    func numberOfRows() -> Int {
        favorites.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> FavoritesCellViewModelProtocol {
        let course =  favorites[indexPath.row]
        return FavoritesCellViewModel(drink: course)
    }
}
