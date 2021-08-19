//
//  CocktailsCollectionController.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 12.08.2021.
//

import UIKit


class CocktailsCollectionController: UICollectionViewController {
    
    private var drinks: [Drinks] = []
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
        collectionView.backgroundColor = .white
        setupSearchController()
        fetchData(from: URLexemples.url.rawValue + name)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar(cocktail?.drinks.count ?? 0)
    }

    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  drink in
            self.cocktail = drink
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func backStarterView(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? drinks.count : cocktail?.drinks.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CocktailCell
        let result = isFiltering ? drinks[indexPath.item] : cocktail?.drinks[indexPath.item]
        cell.configure(with: result)
        return cell

    }
    
    
    private func setupNavigationBar(_ count: Int) {
        if count == 0 {
            titleName = "Ничего не найдено"
        } else {
            titleName = "Поиск по '\(name)' найдено \(count) коктейлей"
        }
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = titleName
        titleLabel.textColor = .gray
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


//extension CocktailsCollectionController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        let urlString = URLexemples.url.rawValue + searchText
//
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
//            NetworkManager.shared.fetchData(from: urlString) { cocktails in
//                self.cocktail = cocktails
//                self.collectionView.reloadData()
//            }
//
//        })
//
//    }
//}

extension CocktailsCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200 , height: 200)
    }
}
