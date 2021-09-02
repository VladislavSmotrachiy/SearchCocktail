//
//  FavoritesCocktailViewController.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.08.2021.
//

import UIKit

class FavoritesCocktailViewController: UITableViewController {
    
    private var cocktails: [FavoritesCocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cocktails = StorageManager.shared.fetchContacts()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  cocktails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! FavoritesCell
        let favorites = cocktails[indexPath.row]
        cell.configure(with: favorites)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cocktails.remove(at: indexPath.row)
            StorageManager.shared.deleteContact(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = cocktails[indexPath.row]
        let detailVC = segue.destination as! DetailVC
        detailVC.indetifaerDetaiOnsegue = false
        detailVC.detailsFavorites = character
    }
}

