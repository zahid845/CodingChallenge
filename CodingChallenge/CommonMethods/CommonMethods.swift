//
//  CommonMethods.swift
//  CodingChallenge
//
//  Created by Zahid Nazir on 31/08/2019.
//  Copyright © 2019 Zahid Nazir. All rights reserved.
//

import UIKit

class CommonMethods: NSObject {
    
    static func showAlert (title: String , message :String , controller : UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
