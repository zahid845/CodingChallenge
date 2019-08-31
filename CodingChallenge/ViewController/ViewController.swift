//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Zahid Nazir on 31/08/2019.
//  Copyright © 2019 Zahid Nazir. All rights reserved.
//

import UIKit
import Segmentio

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

    // Declare Segmented Control
    var customSC : Segmentio!

    var mediaType = MediaType.appleMusic

    /***************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "iTunes Records"

        setupSegmentedControl()
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
        
        recordsTableView.frame = CGRect.init(x: screenBounds.minX, y: customSC.frame.height, width: screenBounds.width, height: screenBounds.height-customSC.frame.height)
        
        recordsTableView.dataSource = self
        recordsTableView.delegate = self
        
        recordsTableView.register(RecordTableCell.self, forCellReuseIdentifier: cellResuseId)
    }
    
    /***************************************************************/
    func setupSegmentedControl(){
        let screenBounds = UIScreen.main.bounds
        let segmentioViewRect = CGRect.init(x: 0, y: 0, width: screenBounds.width, height: 40)
        
        customSC = Segmentio(frame: segmentioViewRect)
        view.addSubview(customSC)
        
        var content = [SegmentioItem]()
        let item1 = SegmentioItem.init(title: MediaType.appleMusic, image: nil)
        let item2 = SegmentioItem.init(title: MediaType.iTunesMusic, image: nil)
        content.append(item1)
        content.append(item2)
        
        
        customSC.setup(
            content: content,
            style: SegmentioStyle.onlyLabel,
            options: SegmentioOptions(
                backgroundColor: .white,
                horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
                verticalSeparatorOptions: segmentioVerticalSeparatorOptions())
        )
        
        customSC.selectedSegmentioIndex = 0
        self.fetchFeeds()
        
        customSC.valueDidChange = { segmentio, segmentIndex in
            self.segmentValueDidChangeAt(index: segmentIndex)
        }
    }
    
    /***************************************************************/
    func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 1,
            color: ColorPalette.whiteSmoke
        )
    }
    
    /***************************************************************/
    func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 1,
            color: ColorPalette.whiteSmoke
        )
    }
    
    /***************************************************************/
    // Handler for Segmented Control changes
    
    @objc func segmentValueDidChangeAt(index: Int) {
        if index == 0{
            mediaType = MediaType.appleMusic
            fetchFeeds()
            
        }else{
            mediaType = MediaType.iTunesMusic
            fetchFeeds()
        }
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
        cell.mediaType = self.mediaType
        cell.selectionStyle = .none

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
        var routeUrl = URL(string: Route.appleMusicURL.url())!
        if(mediaType == MediaType.appleMusic) {
            routeUrl = URL(string: Route.iTunesMusicURL.url())!
            
        }
        ApiManager.sharedApiManager.getFeeds(route: routeUrl, parms: nil, completion: { response in
            DispatchQueue.main.async {
                if response != nil {
                    DispatchQueue.main.async {
                        self.feed = response?.feed
                        self.feedResults = self.feed?.results
                        self.recordsTableView.reloadData()
                    }
                }
                else {
                    CommonMethods.showAlert(title: "error", message: "some thing went wrong please try again", controller: self)
                }
            }
        })
    }
    
}
