//
//  TableCocktailCell.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.07.2021.
//

import UIKit

class CocktailCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCocktail: CocktailImageView!{
        didSet {
            imageCocktail.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var nameCocktail: UILabel!
    
    var viewModel: CocktailCellViewModelProtocol! {
        didSet{
            viewModel.fetchImage(image: imageCocktail)
            nameCocktail.text = viewModel.drinkName
        }
    }
}



