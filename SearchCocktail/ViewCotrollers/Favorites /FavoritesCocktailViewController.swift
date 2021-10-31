//
//  FavoritesCocktailViewController.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.08.2021.
//

import UIKit

class FavoritesCocktailViewController: UITableViewController {
        
    var viewModel: FavoritesViewModelProtocol! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoritesViewModel()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! FavoritesCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsModel = viewModel.detailsViewModel(at: indexPath)
        performSegue(withIdentifier: "Show", sender: detailsModel)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delite(int: indexPath.row)
            viewModel.delitFavorites(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show" {
            guard let detailVC = segue.destination as? DetailVC else { return}
            detailVC.viewModelFavorites = sender as? FavoritesDetailsViewModelProtocol
            detailVC.isSegue = false
        }
    }
}

