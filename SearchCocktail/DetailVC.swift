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

    var detailsCocktail: Drinks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.fetchImage(from: detailsCocktail.images ?? "")
        ingredientCocktail.text = detailsCocktail.ingredient

    }
    

   

}
