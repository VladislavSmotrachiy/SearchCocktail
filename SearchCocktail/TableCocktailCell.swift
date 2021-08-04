//
//  TableCocktailCell.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.07.2021.
//

import UIKit

class TableCocktailCell: UITableViewCell {
    
    
    @IBOutlet weak var imageCocktail: CocktailImageView!{
        didSet {
            imageCocktail.layer.cornerRadius = 40
        }
    }
    
    @IBOutlet weak var nameCocktail: UILabel!
    
    
    func configure(with result: Drinks?) {
        nameCocktail.text = result?.nameDrink
        imageCocktail.fetchImage(from: result?.images ?? "" )
        
    }
    
}
