//
//  AppStoreTableViewController.swift
//  AppleSearch2
//
//  Created by Blake kvarfordt on 8/15/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class AppStoreTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items = [AppStoreItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? AppStoreTableViewCell
        
        let appStoreItem = items[indexPath.row]
        cell?.appStoreItem = appStoreItem

        
        
        return cell ?? UITableViewCell()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        let type: AppStoreItemController.AppStoreItemType = segmentedControl.selectedSegmentIndex == 0 ? .song : .app
        
        AppStoreItemController.fetchItem(type: type, searchTerm: searchTerm) { (appStoreItems) in
            
            self.items = appStoreItems
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }


}
