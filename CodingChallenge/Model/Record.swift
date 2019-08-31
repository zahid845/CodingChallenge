//
//  Record.swift
//  CodingChallenge
//
//  Created by Zahid Nazir on 31/08/2019.
//  Copyright © 2019 Zahid Nazir. All rights reserved.
//

import Foundation

struct Record : Codable{
    let feed : Feed?
    
    enum CodingKeys: String, CodingKey {
        case feed = "feed"
    }
}

struct Feed : Codable {
    let title : String?
    let id : String?
    let author : Author?
    let links : [Links]?
    let copyright : String?
    let country : String?
    let icon : String?
    let updated : String?
    let results : [Results]?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case id = "id"
        case author = "author"
        case links = "links"
        case copyright = "copyright"
        case country = "country"
        case icon = "icon"
        case updated = "updated"
        case results = "results"
    }
    
}

struct Author : Codable {
    let name : String?
    let uri : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case uri = "uri"
    }
}

struct Links : Codable {
    let selfLink : String?
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
    }
}

struct Results : Codable {
    let artistName : String?
    let id : String?
    let releaseDate : String?
    let name : String?
    let kind : String?
    let copyright : String?
    let artistId : String?
    let contentAdvisoryRating : String?
    let artistUrl : String?
    let artworkUrl100 : String?
    let genres : [Genres]?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case artistName = "artistName"
        case id = "id"
        case releaseDate = "releaseDate"
        case name = "name"
        case kind = "kind"
        case copyright = "copyright"
        case artistId = "artistId"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case artistUrl = "artistUrl"
        case artworkUrl100 = "artworkUrl100"
        case genres = "genres"
        case url = "url"
    }
    
}


struct Genres : Codable {
    let genreId : String?
    let name : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case genreId = "genreId"
        case name = "name"
        case url = "url"
    }
    
}
