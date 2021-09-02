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
    private var drink: Drink?
    
    func configure(with result: Drink?) {
        drink = result
        nameCocktail.text = result?.nameDrink
        imageCocktail.fetchImage(from: result?.images ?? "" )
        addFavorites.addTarget(self, action: #selector(addActionFavorites), for: .touchUpInside)
    }
    
    @objc func addActionFavorites(){
        if isButtonHeart {
            addFavorites.tintColor = .gray
            isButtonHeart.toggle()
        } else {
            let cocktail = FavoritesCocktail.init(
                nameDrink: drink?.nameDrink ?? "" ,
                drinkAlternate: drink?.drinkAlternate ?? "",
                tags: drink?.tags ?? "",
                video: drink?.video ?? "" ,
                category: drink?.category ?? "" ,
                IBA: drink?.IBA  ?? "",
                alcoholic: drink?.alcoholic ?? "",
                glass: drink?.glass ?? "",
                instructions: drink?.instructions ?? "",
                images: drink?.images ?? "",
                dateModified: drink?.dateModified ?? ""
            )
            
            StorageManager.shared.save(contact: cocktail)
            addFavorites.tintColor = .red
            isButtonHeart.toggle()
            print("\(StorageManager.shared.fetchContacts().count)")
        }
    }
}

