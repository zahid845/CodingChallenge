//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Zahid Nazir on 31/08/2019.
//  Copyright © 2019 Zahid Nazir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    /***************************************************************/
    //MARK: - Variables & Constants
    /***************************************************************/
    
    // Object to store complete response of API call
    var feed : Feed? = nil
    
    // Object array to store results array inside response of API call
    var feedResults : [Results]? = nil

    // TableView Initializer
    let cellResuseId = "recordCell"
    let recordsTableView = UITableView()

    /***************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }

    /***************************************************************/
    override func viewWillAppear(_ animated: Bool) {
        self.fetchFeeds()
    }
    
    /***************************************************************/
    func setupTableView(){
        let screenBounds = UIScreen.main.bounds
        view.addSubview(recordsTableView)
        
        recordsTableView.frame = CGRect.init(x: screenBounds.minX, y: screenBounds.minY, width: screenBounds.width, height: screenBounds.height)
        
        recordsTableView.dataSource = self
        recordsTableView.delegate = self
        
        recordsTableView.register(RecordTableCell.self, forCellReuseIdentifier: cellResuseId)
    }
    
    
    /***************************************************************/
    //MARK: - TableView Delegate & DataSource Methods
    /***************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellResuseId, for: indexPath) as! RecordTableCell
        cell.results = feedResults?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}


/***************************************************************/
//MARK:- API Call
/***************************************************************/

extension ViewController {
    
    func fetchFeeds() -> Void {
        ApiManager.sharedApiManager.getFeeds(secondryUrl: "/apple-music/coming-soon/all/10/explicit.json", parms: nil, completion: { response in
            DispatchQueue.main.async {
                if response != nil {
                    DispatchQueue.main.async {
                        self.feed = response?.feed
                        self.feedResults = self.feed?.results
                        self.recordsTableView.reloadData()
                    }
                }
                else {
                    print("some thing went wrong please try again")                    
                }
            }
        })
    }
    
}
