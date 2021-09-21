//
//  TableCocktailCell.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.07.2021.
//

import UIKit

class CocktailCell: UICollectionViewCell {
    
    weak var viewController: UIViewController?
    @IBOutlet var addFavorites: UIButton!
    @IBOutlet weak var imageCocktail: CocktailImageView!{
        didSet {
            imageCocktail.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var nameCocktail: UILabel!
    private var isButtonHeart = false
    private var drink: Drink?
    private var favorites: FavoritesCocktail!
    
    func configure(with result: Drink?) {
        drink = result
        nameCocktail.text = result?.nameDrink
        imageCocktail.fetchImage(from: result?.images ?? "" )
        addFavorites.addTarget(self, action: #selector(addActionFavorites), for: .touchUpInside)
    }
    
    @objc func addActionFavorites(){
        let cocktail = FavoritesCocktail.init(
            id: drink?.id ?? "",
            nameDrink: drink?.nameDrink ?? "" ,
            drinkAlternate: drink?.drinkAlternate ?? "",
            tags: drink?.tags ?? "",
            video: drink?.video ?? "",
            category: drink?.category ?? "",
            IBA: drink?.IBA ?? "",
            alcoholic: drink?.alcoholic ?? "",
            glass: drink?.glass ?? "",
            instructions: drink?.instructions ?? "",
            images: drink?.images ?? "",
            ingredientFirst: drink?.ingredientFirst ?? "",
            ingredientSecond: drink?.ingredientSecond ?? "",
            ingredientThrid: drink?.ingredientThrid ?? "",
            ingredientFourth: drink?.ingredientFourth ?? "",
            ingredientFifth: drink?.ingredientFifth ?? "",
            ingredientSixth: drink?.ingredientSixth ?? "",
            proportionFirst: drink?.proportionFirst ?? "",
            proportionSecond: drink?.proportionSecond ?? "",
            proportionThrid: drink?.proportionThrid ?? "",
            proportionFourth: drink?.proportionFourth ?? "",
            proportionFifth: drink?.proportionFifth ?? "",
            proportionSixth: drink?.proportionSixth ?? "",
            dateModified: drink?.dateModified ?? ""
        )
        
        if !StorageManager.shared.fetchFavorites().contains(where: { a in
            a.id == cocktail.id
        }) {
            StorageManager.shared.save(contact: cocktail)
            addFavorites.tintColor = .red
            isButtonHeart.toggle()
        } else {
            addFavorites.tintColor = .gray
            successAlert()
        }
    }
    
    private func successAlert() {
        let alert = UIAlertController(
            title: "Уже в избраном",
            message: "Коктель не возможно добавить, он уже находить в избраном",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        isButtonHeart = true
        addFavorites.tintColor = .red
        alert.addAction(okAction)
        self.viewController?.present(alert, animated: true)
    }
}



