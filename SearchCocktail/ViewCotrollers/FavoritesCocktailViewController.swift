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
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(Base.shared.selected.count)")
   return  Base.shared.selected.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! FavoritesCell
        
        let favorites = Base.shared.selected[indexPath.row]
        
        cell.configure(with: favorites)
    
        return cell
    }
   

}
