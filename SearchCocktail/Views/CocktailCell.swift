//
//  TableCocktailCell.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.07.2021.
//

import UIKit

class CocktailCell: UICollectionViewCell {
    
    @IBOutlet var addFavorites: UIButton!
    @IBOutlet weak var imageCocktail: CocktailImageView!{
        didSet {
            imageCocktail.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var nameCocktail: UILabel!
    private var isButtonHeart = false
    
    func configure(with result: Drink?) {
        nameCocktail.text = result?.nameDrink
        imageCocktail.fetchImage(from: result?.images ?? "" )
        addFavorites.addTarget(self, action: #selector(addActionFavorites), for: .touchUpInside)
    }
    
    @objc func addActionFavorites(_ sender: UIButton){
        if isButtonHeart {
            sender.tintColor = .gray
            isButtonHeart.toggle()
        } else {
            sender.tintColor = .red
            isButtonHeart.toggle()
        }
        
        
    }
}
