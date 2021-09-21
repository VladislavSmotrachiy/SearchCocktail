//
//  InfoOnCocktail.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 19.08.2021.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet var nameCocktail: UILabel!
    @IBOutlet var glass: UILabel!
    @IBOutlet var instruction: UILabel!
    @IBOutlet var ingredientFirst: UILabel!
    @IBOutlet var ingredientSecond: UILabel!
    @IBOutlet var ingredientThrid: UILabel!
    @IBOutlet var ingredientFourth: UILabel!
    @IBOutlet var ingredientFifth: UILabel!
    @IBOutlet var ingredientSixth: UILabel!
    @IBOutlet var detailImage: CocktailImageView! {
        didSet {
            detailImage.layer.cornerRadius = detailImage.frame.width / 2
        }
    }
    
    var drinkDetail: Drink!
    var favoritesDetail: FavoritesCocktail!
    var indetifaerDetaiOnSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if indetifaerDetaiOnSegue {
            detailImage.fetchImage(from: drinkDetail.images ?? "")
            setupNavigationBar(title: drinkDetail.nameDrink)
        } else {
            detailImage.fetchImage(from: favoritesDetail.images ?? "")
            setupNavigationBar(title: favoritesDetail.nameDrink ?? "")
            fatchDetailsCocktailFromFavorites()
        }
    }
    
    private func setupNavigationBar(title: String) {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        navigationItem.titleView = titleLabel
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
    }
    
    private func fatchDetailsCocktailFromFavorites(){
        nameCocktail.text = favoritesDetail.nameDrink
        instruction.text = favoritesDetail.instructions
        ingredientFirst.text = favoritesDetail.firstPosition
        ingredientSecond.text = favoritesDetail.secondPosition
        glass.text = favoritesDetail.glass
        
        if favoritesDetail.ingredientThrid == ""{
            ingredientThrid.text = ""
        } else {
            ingredientThrid.text = favoritesDetail.thridPosition
        }
        
        if favoritesDetail.ingredientFourth == ""{
            ingredientFourth.text = ""
        } else {
            ingredientFourth.text = favoritesDetail.fourthPosition
        }
        
        if favoritesDetail.ingredientFifth == "" {
            ingredientFifth.text = ""
        } else {
            ingredientFifth.text = favoritesDetail.fifthPosition
        }
        
        if favoritesDetail.ingredientSixth == "" {
            ingredientSixth.text = ""
        } else {
            ingredientSixth.text = favoritesDetail.sixthPosition
        }
        
    }
    
    private func fatchDetailsCocktailFromNetwork() {
        
    }
}
