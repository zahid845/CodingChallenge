//
//  ApiManager.swift
//  CodingChallenge
//
//  Created by Zahid Nazir on 31/08/2019.
//  Copyright © 2019 Zahid Nazir. All rights reserved.
//

import UIKit
import Alamofire

class ApiManager: NSObject {
    static let sharedApiManager = ApiManager()
    
    func getFeeds( secondryUrl:String, parms : Parameters?,   completion: @escaping (_ success: Record?) -> Void) {
        
        let url = "https://rss.itunes.apple.com/api/v1/us" + secondryUrl
        Alamofire.request(url, method:.get, parameters:parms, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    let feedBackData = try decoder.decode(Record.self, from: response.data!)
                    completion(feedBackData)
                } catch let err {
                    print("Err", err)
                    completion(nil)
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }

}
