//
//  AppStoreItem.swift
//  AppleSearch2
//
//  Created by Blake kvarfordt on 8/15/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

struct AppStoreItem {
    
    let title: String
    let subtitle: String
    let imageURL: String
}

extension AppStoreItem {
    
    init(jsonObject: SongObject) {
        
        self.title = jsonObject.title
        self.subtitle = jsonObject.subtitle
        self.imageURL = jsonObject.imageURL
    }
    
    init(jsonObject: AppObject) {
        
        self.title = jsonObject.title
        self.subtitle = jsonObject.subtitle
        self.imageURL = jsonObject.imageURL
    }
    
    
}
