//
//  RecordTableCell.swift
//  CodingChallenge
//
//  Created by Zahid Nazir on 31/08/2019.
//  Copyright © 2019 Zahid Nazir. All rights reserved.
//

import UIKit
import Kingfisher

class RecordTableCell: UITableViewCell {

    /***************************************************************/
    //MARK: - Configure cell
    /***************************************************************/
    
    var mediaType: String? {
        didSet {
            mediaTypeLabel.text = " \(mediaType ?? "  ") "
        }
    }
    
    var results:Results? {
        didSet {
            guard let recordItem = results else {return}
            
            //Asynchronous downloading and caching of image from given URL using KingFisher Library
            
            if let imgUrlString = recordItem.artworkUrl100 {
                let imgSize = CGSize.init(width: 70, height: 70)
                let processor = DownsamplingImageProcessor(size: imgSize)
                    >> RoundCornerImageProcessor(cornerRadius: 20)
                imgView.kf.indicatorType = .activity
                let imgUrl = URL.init(string: imgUrlString)
                imgView.kf.setImage(
                    with: imgUrl,
                    placeholder: UIImage(named: "placeHolderImage"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
                {
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
            }
            
            if let name = recordItem.name {
                nameLabel.text = " \(name) "
            }
            
        }
    }
    
    
    /***************************************************************/
    //MARK: - Initialize UI-Elements
    /***************************************************************/
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imgView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 7
        img.clipsToBounds = true
        return img
    }()
    
    let mediaTypeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor =  UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    /***************************************************************/
    //MARK: - Add UI-Elements to cell & set constraints
    /***************************************************************/
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imgView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(mediaTypeLabel)
        self.contentView.addSubview(containerView)
        
        imgView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        imgView.widthAnchor.constraint(equalToConstant:70).isActive = true
        imgView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo:self.imgView.trailingAnchor, constant:10).isActive = true
        
        containerView.topAnchor.constraint(equalTo:self.imgView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
        
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        //   containerView.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        nameLabel.numberOfLines = 0
        mediaTypeLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        mediaTypeLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        
        //     mediaTypeLabel.heightAnchor.constraint(equalToConstant:17).isActive = true
        
    }
    
    /***************************************************************/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
