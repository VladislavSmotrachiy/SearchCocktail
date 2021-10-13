//
//  CocktailsCollectionController.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 12.08.2021.
//

import UIKit


class CocktailsCollectionController: UICollectionViewController {
    
    var viewModel: CocktailsViewModelProtocol! {
        didSet{
            viewModel.fetchCourses {
                self.collectionView.reloadData()
                self.setupNavigationBar()
            }
        }
    }
    
    private var drinks: [Drink] = []
    private var cocktail: Cocktail?
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
        ActivityIndicator.shared.animateActivity(title: "Загрузка", view: self.view, navigationItem: self.navigationItem)
        viewModel = CocktailViewModel(api: name)
        collectionView.backgroundColor = .white
        setupSearchController()
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CocktailCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = cocktail?.drinks[indexPath.row]
        performSegue(withIdentifier: "show", sender: result)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
            let character = cocktail?.drinks[indexPath.first?.item ?? 0]
            guard let detailVC = segue.destination as? DetailVC else { return }
            detailVC.drinkDetail = character
            detailVC.indetifaerDetaiOnSegue = true
            print("\(character?.nameDrink ?? "")")
        }
    }
    
    @IBAction func buttonActionSegueOnFavorites(_ sender: Any) {
        performSegue(withIdentifier: "showFavorites", sender: nil)
    }
    @IBAction func backStarterView(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        
    }
    private func fetchData() {
        NetworkManager.shared.fetchData(string: name) { cocktail in
            self.cocktail = cocktail
            self.setupNavigationBar()
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
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension CocktailsCollectionController {
    
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        if viewModel.numberOfRows() != 0 {
            ActivityIndicator.shared.stopAnimating(navigationItem: navigationItem)
            title = "Поиск по '\(name)' найдено \(viewModel.numberOfRows()) совпадений"
        }
        
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
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
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
            textField.textColor = .darkGray
        }
    } 
}


