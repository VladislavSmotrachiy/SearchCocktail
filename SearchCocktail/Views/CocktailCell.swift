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
    @objc func addActionFavorites(){
        if isButtonHeart {
            addFavorites.tintColor = .gray
            isButtonHeart.toggle()
        } else {
            addFavorites.tintColor = .red
            isButtonHeart.toggle()
            print("\(Base.shared.selected.count)")
        }
   
    }
    
    func save( result: Drink?) {
    Base.shared.saveFavorites(id: result?.id , nameDrink: result?.nameDrink , drinkAlternate: result?.drinkAlternate ?? "", tags: result?.tags , video: result?.video , category: result?.category , IBA: result?.IBA , alcoholic: result?.alcoholic ?? "", glass: result?.glass ?? "", instructions: result?.instructions ?? "", images: result?.images ?? "",  dateModified: result?.dateModified ?? "")
    }
    }

