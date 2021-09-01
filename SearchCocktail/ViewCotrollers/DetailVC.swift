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
    
    @IBOutlet var ingredientCocktail: UILabel!

    var detailsCocktail: Drink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.fetchImage(from: detailsCocktail.images ?? "")
        ingredientCocktail.text = detailsCocktail.ingredient
        setupNavigationBar()

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
