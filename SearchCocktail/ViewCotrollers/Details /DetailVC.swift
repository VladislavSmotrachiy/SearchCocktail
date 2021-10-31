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
    
    var viewModel: DetailsViewModelProtocol!
    var viewModelFavorites: FavoritesDetailsViewModelProtocol!
    
    var isSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isSegue {
            setupFromTheNetwork()
        } else {
            setupFromFavorites()
        }
    }
    
    @IBAction func buttonAddToFavorites(_ sender: UIButton) {
        viewModel.favoriteButtonPressed()
        if !viewModel.isFavorite {
            successAlert()
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
    
    private func setStatusForFavoriteButton() {
            buttonFavorites.tintColor = viewModel.isFavorite ? .gray : .red
    }
    
    private func setupFromFavorites() {
        setupNavigationBar(title: viewModelFavorites.nameCocktail)
        viewModelFavorites.fetchImage(image: detailImage)
        fatchDetails(name: viewModelFavorites.nameCocktail,
                     instructions: viewModelFavorites.instruction,
                     glassCocktail: viewModelFavorites.glass,
                     firstIngredient: viewModelFavorites.ingredientFirst,
                     secondIngredient: viewModelFavorites.ingredientSecond,
                     thridIngredient: viewModelFavorites.ingredientThrid,
                     fourthIngredient: viewModelFavorites.ingredientFourth,
                     fifthIngredient: viewModelFavorites.ingredientFifth,
                     sixthIngredient: viewModelFavorites.ingredientSixth,
                     positionFirst: viewModelFavorites.firstPosition,
                     positionSecond: viewModelFavorites.secondPosition,
                     positionThrid: viewModelFavorites.thridPosition,
                     positionFourth: viewModelFavorites.fourthPosition,
                     positionFifth: viewModelFavorites.fifthPosition,
                     positionSixth: viewModelFavorites.sixthPosition)
        buttonFavorites.tintColor = .red
        buttonFavorites.isUserInteractionEnabled = false
        buttonFavorites.alpha = 1.0
    }
    
    
    private func setupFromTheNetwork() {
        viewModel.viewModelDidChange = { [weak self] viewModel in
            self?.setStatusForFavoriteButton()
        }
        setupNavigationBar(title: viewModel.nameCocktail)
        viewModel.fetchImage(image: detailImage)
        fatchDetails(name: viewModel.nameCocktail,
                     instructions: viewModel.instruction,
                     glassCocktail: viewModel.glass,
                     firstIngredient: viewModel.ingredientFirst,
                     secondIngredient: viewModel.ingredientSecond,
                     thridIngredient: viewModel.ingredientThrid,
                     fourthIngredient: viewModel.ingredientFourth,
                     fifthIngredient: viewModel.ingredientFifth,
                     sixthIngredient: viewModel.ingredientSixth,
                     positionFirst: viewModel.firstPosition,
                     positionSecond: viewModel.secondPosition,
                     positionThrid: viewModel.thridPosition,
                     positionFourth: viewModel.fourthPosition,
                     positionFifth: viewModel.fifthPosition,
                     positionSixth: viewModel.sixthPosition)
        if viewModel.isFavoritesHeart {
            buttonFavorites.tintColor = .red
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
