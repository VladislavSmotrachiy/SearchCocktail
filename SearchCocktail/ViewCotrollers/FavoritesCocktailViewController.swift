//
//  FavoritesCocktailViewController.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 30.08.2021.
//

import UIKit

class FavoritesCocktailViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(StorageManager.shared.selected.count)")
        return  StorageManager.shared.selected.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! FavoritesCell
        let favorites = StorageManager.shared.selected[indexPath.row]
        cell.configure(with: favorites)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.shared.selected.remove(at: indexPath.row)
            StorageManager.shared.deleteContact(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
