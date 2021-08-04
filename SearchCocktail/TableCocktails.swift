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
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        tableView.rowHeight = 100
        tableView.backgroundColor = .white
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
    

    @IBAction func backStarterView(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        
        
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {  drink in
            self.cocktail = drink
            self.tableView.reloadData()
        }
    }
   
    private func setupNavigationBar() {
        
        
        let titleFont = UIFont.systemFont(ofSize: 24.0)
            let title = name
            let titleSize = title.size(withAttributes: [.font: titleFont])
            let frame = CGRect(x: 0, y: 0, width: titleSize.width, height: 20.0)
            let titleLabel = UILabel(frame: frame)
            titleLabel.font = titleFont
            titleLabel.textAlignment = .center
            titleLabel.text = title
            titleLabel.textColor = .brown
            navigationItem.titleView = titleLabel

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
