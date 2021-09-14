//
//  InfoOnCocktail.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 19.08.2021.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet var detailImage: CocktailImageView! {
        didSet {
            detailImage.layer.cornerRadius = detailImage.frame.width / 2
        }
    }
    
    
    var detailsCocktail: Drink!
    var detailsFavorites: FavoritesCocktail!
    var indetifaerDetaiOnsegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if indetifaerDetaiOnsegue {
            detailImage.fetchImage(from: detailsCocktail.images ?? "")
//            ingredientCocktail.text = detailsCocktail.ingredient
            setupNavigationBar()
        } else {
            detailImage.fetchImage(from: detailsFavorites.images ?? "")
//            ingredientCocktail.text = detailsFavorites.instructions
        }
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = detailsCocktail.nameDrink
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        navigationItem.titleView = titleLabel
        
        // Navigation bar appearance
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .white
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
}
