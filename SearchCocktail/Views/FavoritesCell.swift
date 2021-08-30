//
//  FavoritesCell.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.08.2021.
//

import UIKit

class FavoritesCell: UITableViewCell {

    @IBOutlet var imageFavorites: CocktailImageView! {
        didSet {
            imageFavorites.layer.cornerRadius = imageFavorites.frame.height / 2
        }
    }
    @IBOutlet var nameFavorites: UILabel!
    
    func configure(with result: Base.FavoritesCocktail?) {
        nameFavorites.text = result?.nameDrink
        imageFavorites.fetchImage(from: result?.images ?? "" )
    }

}
