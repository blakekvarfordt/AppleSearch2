//
//  AppStoreItemController.swift
//  AppleSearch2
//
//  Created by Blake kvarfordt on 8/15/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import UIKit.UIImage

class AppStoreItemController {
    
    static func fetchItem(type: AppStoreItemType, searchTerm: String, completion: @escaping ([AppStoreItem]) -> Void) {
        
        // Base URl
        guard let baseURl = URL(string: "https://itunes.apple.com/search") else { completion([]); return }
        // Add query items to URL
        var urlComponents = URLComponents(url: baseURl, resolvingAgainstBaseURL: true)
        // search term
        let searchTermItem = URLQueryItem(name: "term", value: searchTerm)
        // searchType
        let searchTypeItem = URLQueryItem(name: "entity", value: type.rawValue)
        // Add Items to components
        urlComponents?.queryItems = [searchTermItem, searchTypeItem]
        // Final URL
        guard let finalURL = urlComponents?.url else { completion([]); return }
        print(finalURL)
        
        // URL Session
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // check for error
            if let error = error { completion([]); print(error); return }
            // verify if there is data
            guard let data = data else { completion([]); return }
            // decode
            do {
                let decoder = JSONDecoder()
                
                switch type {
                    
                    case .app:
                        // Decode App Object
                        let topLevelObject = try decoder.decode(TopLevelAppObject.self, from: data)
                        // PlaceHolder
                        var decodedAppItems = [AppStoreItem]()
                        // Loop through and initialize app items
                        for object in topLevelObject.results {
                            // turn the AppStoreItem into the object that has the data
                             let newItem = AppStoreItem(jsonObject: object)
                            // append the new item to the array
                            decodedAppItems.append(newItem)
                    }
                    // seal the deal with a new app item
                    completion(decodedAppItems)
                    
                    case .song:
                        // Decode Song Object
                        let topLevelObject = try decoder.decode(TopLevelSongObject.self, from: data)
                        // PlaceHolder
                        var decodedSongItem = [AppStoreItem]()
                        // Loop through and initialize song items
                        for object in topLevelObject.results {
                            // turn the object into an AppStoreItem
                            let newItem = AppStoreItem(jsonObject: object)
                            // append newItem to the placeholder
                            decodedSongItem.append(newItem)
                            
                    }
                    // seal the deal with a new song item
                    completion(decodedSongItem)
                }
            } catch {
                
            }
            
            
        } .resume()
        
        
    }
    
    
    // fetch Image
    static func fetchImage(item: AppStoreItem, completion: @escaping (UIImage?) -> Void) {
        
        guard let imageURL = URL(string: item.imageURL) else { completion(nil); return }
        print(imageURL)
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            
            if let error = error { completion(nil); print(error); return }
            
            guard let data = data else { completion(nil); return }
            
            let image = UIImage(data: data)
            completion(image)
        } .resume()
    }
    
    enum AppStoreItemType: String {
        case song = "musicTrack"
        case app = "software"
    }
}
