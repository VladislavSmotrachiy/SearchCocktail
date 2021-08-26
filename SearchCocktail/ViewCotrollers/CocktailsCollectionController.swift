//
//  CocktailsCollectionController.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 12.08.2021.
//

import UIKit


class CocktailsCollectionController: UICollectionViewController {
    
    private var drinks: [Drink] = []
    private var cocktail: Cocktail?
    private var isButtonHeart = false
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var name = ""
    var titleName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        setupSearchController()
        fetchData(from: URLexemples.url.rawValue + name)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltering ? drinks.count : cocktail?.drinks.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CocktailCell
        
        let result = isFiltering ? drinks[indexPath.row] : cocktail?.drinks[indexPath.row]
        
        cell.configure(with: result)
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cocktailAction =  isFiltering ? drinks[indexPath.row] : cocktail?.drinks[indexPath.row]
        
        switch cocktailAction {
        case .none: print("Нету")
        case .some(_): performSegue(withIdentifier: "show", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
        if segue.identifier == "show" {
            let character = isFiltering ? drinks[indexPath.first?.item ?? 0] : cocktail?.drinks[indexPath.first?.item ?? 0]
            guard let detailVC = segue.destination as? DetailVC else { return }
            detailVC.detailsCocktail = character
            print("\(character?.nameDrink ?? "")")
        }
    }
    
    @IBAction func backStarterView(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func addToFavourites(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to:collectionView)
        guard let indexPath = collectionView!.indexPathForItem(at: point) else {return}
        let character = isFiltering ? drinks[indexPath.item] : cocktail?.drinks[indexPath.item]

        sender.tintColor = isButtonHeart ? .gray : .red
        isButtonHeart.toggle()
            
        print("\(character?.nameDrink ?? "1")")
    }
    
    
    private func setupNavigationBar() {
        if isFiltering ? drinks.count == 0 : cocktail?.drinks.count ?? 0 == 0 {
            titleName = "Ничего не найдено"
        } else {
            titleName = "Поиск по '\(name)' найдено \(isFiltering ? drinks.count : cocktail?.drinks.count ?? 0) совпадений"
        }
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = titleName
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
    
// MARK: - SearchController
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .green
        }
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  drink in
            self.cocktail = drink
            self.collectionView.reloadData()
        }
    }
}


// MARK: - UISearchResultsUpdating
extension CocktailsCollectionController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        drinks = cocktail?.drinks.filter { chracter in
            chracter.nameDrink.lowercased().contains(searchText.lowercased())
        } ?? []
        collectionView.reloadData()
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension CocktailsCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3*16) / 2
       return CGSize(width: width , height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 5, bottom: 16, right: 5)
        }
}
