//
//  RouteUrls.swift
//  CodingChallenge
//
//  Created by Zahid Nazir on 31/08/2019.
//  Copyright © 2019 Zahid Nazir. All rights reserved.
//


enum Route: String {

    case appleMusicURL = "/apple-music/coming-soon/all/10/explicit.json"
    case iTunesMusicURL = "/itunes-music/hot-tracks/all/10/explicit.json"
    
    func url() -> String{
        return Constants.BaseURL + self.rawValue
    }
    
}
