//
//  AppStoreClient.swift
//  AppleSearch2
//
//  Created by Blake kvarfordt on 8/15/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

// Songs

// Top Level Song Object
struct TopLevelSongObject: Decodable {
    
    let results: [SongObject]
}

// Second Level
struct SongObject: Decodable {
    
    // properties we want
    let title: String
    let subtitle: String
    let imageURL: String
    
    // coding Keys to get them
    private enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case subtitle = "artistName"
        case imageURL = "artworkUrl100"
    }
    
}

// Apps

// Top Level App Object
struct TopLevelAppObject: Decodable {
    let results: [AppObject]
}


struct AppObject: Decodable {
    
    let title: String
    let subtitle: String
    let imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case subtitle = "description"
        case imageURL = "artworkUrl100"
    }
}

