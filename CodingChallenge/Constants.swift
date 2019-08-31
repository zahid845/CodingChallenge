//
//  Constants.swift
//  CodingChallenge
//
//  Created by Zahid Nazir on 31/08/2019.
//  Copyright © 2019 Zahid Nazir. All rights reserved.
//

import UIKit

struct Constants{
    static let BaseURL = "https://rss.itunes.apple.com/api/v1/us"
}

struct ColorPalette {
    
    static let coral = UIColor(red: 244/255, green: 111/255, blue: 96/255, alpha: 1.0)
    static let whiteSmoke = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    static let grayChateau = UIColor(red: 163/255, green: 164/255, blue: 168/255, alpha: 1.0)
    
}

enum MediaType {
    static let appleMusic = "Apple Music"
    static let iTunesMusic = "iTunes Music"
}
