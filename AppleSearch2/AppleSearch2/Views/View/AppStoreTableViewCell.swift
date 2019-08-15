//
//  AppStoreTableViewCell.swift
//  AppleSearch2
//
//  Created by Blake kvarfordt on 8/15/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class AppStoreTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellSubtitleLabel: UILabel!
    
    // MARK: - Properties

    var appStoreItem: AppStoreItem? {
        didSet {
            updateViews()
        }
    }
    
    
    
    
    // MARK: - Custom Methods
    
    func updateViews() {
        
        guard let item = appStoreItem else {
            
            cellTitleLabel.text = ""
            cellSubtitleLabel.text = ""
            cellImageView.image = nil
            return
        }
        
        cellTitleLabel.text = item.title
        cellSubtitleLabel.text = item.subtitle
        
        
        // Fetch image
            AppStoreItemController.fetchImage(item: item) { (image) in
                DispatchQueue.main.async {
                    self.cellImageView.image = image
                }
            }
        
        
//            AppStoreItemController.fetchImage(item: item) { (image) in
//                DispatchQueue.main.async {
//                    self.cellImageView.image = image
//                }
//            }
    }
    
    
    
    
}
