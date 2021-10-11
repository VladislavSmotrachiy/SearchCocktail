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
    @IBOutlet var buttonFavorites: UIButton!
    var drinkDetail: Drink!
    var favoritesDetail: FavoritesCocktail!
    var indetifaerDetaiOnSegue = false
    private var isButtonHeart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        details()
    }
    
    @IBAction func buttonAddToFavorites(_ sender: UIButton) {
        let cocktailFavorites = FavoritesCocktail.init(
            id: drinkDetail?.id ?? "",
            nameDrink: drinkDetail?.nameDrink ?? "" ,
            drinkAlternate: drinkDetail?.drinkAlternate ?? "",
            tags: drinkDetail?.tags ?? "",
            video: drinkDetail?.video ?? "",
            category: drinkDetail?.category ?? "",
            IBA: drinkDetail?.IBA ?? "",
            alcoholic: drinkDetail?.alcoholic ?? "",
            glass: drinkDetail?.glass ?? "",
            instructions: drinkDetail?.instructions ?? "",
            images: drinkDetail?.images ?? "",
            ingredientFirst: drinkDetail?.ingredientFirst ?? "",
            ingredientSecond: drinkDetail?.ingredientSecond ?? "",
            ingredientThrid: drinkDetail?.ingredientThrid ?? "",
            ingredientFourth: drinkDetail?.ingredientFourth ?? "",
            ingredientFifth: drinkDetail?.ingredientFifth ?? "",
            ingredientSixth: drinkDetail?.ingredientSixth ?? "",
            proportionFirst: drinkDetail?.proportionFirst ?? "",
            proportionSecond: drinkDetail?.proportionSecond ?? "",
            proportionThrid: drinkDetail?.proportionThrid ?? "",
            proportionFourth: drinkDetail?.proportionFourth ?? "",
            proportionFifth: drinkDetail?.proportionFifth ?? "",
            proportionSixth: drinkDetail?.proportionSixth ?? "",
            dateModified: drinkDetail?.dateModified ?? ""
        )
        
        if StorageManager.shared.fetchFavorites().contains(where: { a in
            a.id == cocktailFavorites.id
        }) {
            sender.tintColor = .red
            successAlert()
            print(isButtonHeart)
        } else {
            StorageManager.shared.save(contact: cocktailFavorites)
            sender.tintColor = .red
            isButtonHeart.toggle()
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
    
    // MARK: - FatchDetails
    
    private func details(){
        if indetifaerDetaiOnSegue {
            detailImage.fetchImage(from: drinkDetail.images ?? "")
            setupNavigationBar(title: drinkDetail.nameDrink)
            fatchDetails(name: drinkDetail.nameDrink,
                         instructions: drinkDetail.instructions ?? "",
                         glassCocktail: drinkDetail.glass ?? "",
                         firstIngredient: drinkDetail.ingredientFirst,
                         secondIngredient: drinkDetail.ingredientSecond,
                         thridIngredient: drinkDetail.ingredientThrid,
                         fourthIngredient: drinkDetail.ingredientFourth,
                         fifthIngredient: drinkDetail.ingredientFifth,
                         sixthIngredient: drinkDetail.ingredientSixth,
                         positionFirst: drinkDetail.firstPosition,
                         positionSecond: drinkDetail.secondPosition,
                         positionThrid: drinkDetail.thridPosition,
                         positionFourth: drinkDetail.fourthPosition,
                         positionFifth: drinkDetail.fifthPosition,
                         positionSixth: drinkDetail.sixthPosition)
            if StorageManager.shared.fetchFavorites().contains(where: { a in
                a.id == drinkDetail.id
            }) {
                buttonFavorites.tintColor = .red
            }
        } else {
         detailImage.fetchImage(from: favoritesDetail.images ?? "")
            setupNavigationBar(title: favoritesDetail.nameDrink ?? "")
            fatchDetails(name: favoritesDetail.nameDrink ?? "",
                         instructions: favoritesDetail.instructions ?? "",
                         glassCocktail: favoritesDetail.glass ?? "",
                         firstIngredient: favoritesDetail.ingredientFirst,
                         secondIngredient: favoritesDetail.ingredientSecond,
                         thridIngredient: favoritesDetail.ingredientThrid,
                         fourthIngredient: favoritesDetail.ingredientFourth,
                         fifthIngredient: favoritesDetail.ingredientFifth,
                         sixthIngredient: favoritesDetail.ingredientSixth,
                         positionFirst: favoritesDetail.firstPosition,
                         positionSecond: favoritesDetail.secondPosition,
                         positionThrid: favoritesDetail.thridPosition,
                         positionFourth: favoritesDetail.fourthPosition,
                         positionFifth: favoritesDetail.fifthPosition,
                         positionSixth: favoritesDetail.sixthPosition)
            buttonFavorites.tintColor = .red
            buttonFavorites.isUserInteractionEnabled = false
        }
    }
    private func fatchDetails(
        name: String, instructions: String,
        glassCocktail: String, firstIngredient: String?,
        secondIngredient: String?, thridIngredient: String?,
        fourthIngredient: String?, fifthIngredient: String?,
        sixthIngredient: String?, positionFirst: String,
        positionSecond: String, positionThrid: String,
        positionFourth: String, positionFifth: String,
        positionSixth: String ) {
            
            nameCocktail.text = name
            instruction.text = instructions
            glass.text = glassCocktail
            
            if firstIngredient == nil || firstIngredient == "" {
                ingredientFirst.text = ""
            } else {
                ingredientFirst.text = positionFirst
            }
            if secondIngredient == nil || secondIngredient == "" {
                ingredientSecond.text = ""
            } else {
                ingredientSecond.text = positionSecond
            }
            
            if thridIngredient == nil || thridIngredient == "" {
                ingredientThrid.text = ""
            } else {
                ingredientThrid.text = positionThrid
            }
            
            if fourthIngredient == nil || fourthIngredient == "" {
                ingredientFourth.text = ""
            } else {
                ingredientFourth.text = positionFourth
            }
            
            if fifthIngredient == nil || fifthIngredient == "" {
                ingredientFifth.text = ""
            } else {
                ingredientFifth.text = positionFifth
            }
            
            if sixthIngredient == nil || sixthIngredient == "" {
                ingredientSixth.text = ""
            } else {
                ingredientSixth.text = positionSixth
            }
        }
    
    private func successAlert() {
        let alert = UIAlertController(
            title: "Уже в избраном",
            message: "",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
