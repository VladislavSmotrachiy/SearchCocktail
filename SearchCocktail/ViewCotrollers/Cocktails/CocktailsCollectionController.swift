//
//  CocktailsCollectionController.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 12.08.2021.
//

import UIKit


class CocktailsCollectionController: UICollectionViewController {
    
    var viewModel: CocktailsViewModelProtocol! {
        didSet {
            viewModel.fetchCourses {
                self.collectionView.reloadData()
            }
        }
    }
    
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
        
        viewModel = CocktailViewModel(string: name)
        ActivityIndicator.shared.animateActivity(title: "Загрузка...", view: self.view, navigationItem: self.navigationItem)
        collectionView.backgroundColor = .white
        setupSearchController()
        fetchAlertError()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupNavigationBar()
    }

    private func fetchAlertError() {
        if viewModel.checkError() {
            successAlert(title: viewModel.errors()!)
        } else {
            viewModel.fetchCourses {
                self.successAlert(title: self.viewModel.errors()!)
            }
        }
    }
    
    private func successAlert(title: Error) {
        let alert = UIAlertController(
            title: "\(String(describing: title))",
            message: "",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows(bool: isFiltering)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CocktailCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath, bool: isFiltering)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailsModel = viewModel.detailsViewModel(at: indexPath, bool: isFiltering)
        print("\(detailsModel.nameCocktail)")
        performSegue(withIdentifier: "show", sender: detailsModel)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            guard let detailVC = segue.destination as? DetailVC else { return }
            detailVC.viewModel = sender as? DetailsViewModelProtocol
            detailVC.isSegue = true
        }
    }
    
    @IBAction func buttonActionSegueOnFavorites(_ sender: Any) {
        performSegue(withIdentifier: "showFavorites", sender: nil)
    }
    @IBAction func backStarterView(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension CocktailsCollectionController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel.filterDrink = viewModel.drinks.filter { chracter in
            chracter.nameDrink.lowercased().contains(searchText.lowercased())
        }
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
        collectionView.reloadData()
        if viewModel.numberOfRows(bool: isFiltering) != 0 {
            ActivityIndicator.shared.stopAnimating(navigationItem: navigationItem)
            title = "Поиск по '\(name)' найдено \(viewModel.numberOfRows(bool: isFiltering)) совпадений"
        } else {
            title = "ничего не найдено"
        }
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 14)
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


