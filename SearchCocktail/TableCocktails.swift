//
//  TableCocktails.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 23.07.2021.
//

import UIKit

class TableCocktails: UITableViewController {
    
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        tableView.backgroundColor = .black
        setupNavigationBar()
        setupSearchController()
        fetchData(from: URLexemples.url.rawValue + name)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? drinks.count : cocktail?.drinks.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCocktailCell
        
        let result = isFiltering ? drinks[indexPath.row] : cocktail?.drinks[indexPath.row]
        cell.configure(with: result)
        return cell
    }
    


    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  drink in
            self.cocktail = drink
            self.tableView.reloadData()
        }
    }
   
    private func setupNavigationBar() {
        
        title = name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Navigation bar appearance
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .black
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.red]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red]

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
    }

    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
       definesPresentationContext = true

    }
}
// MARK: - UISearchResultsUpdating
extension TableCocktails: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        drinks = cocktail?.drinks.filter { chracter in
            chracter.nameDrink.lowercased().contains(searchText.lowercased())
        } ?? []
        tableView.reloadData()
    }

}
