//
//  TweetTableViewCell.swift
//  SmashTag
//
//  Created by abdelrahman mohamed on 2/25/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet? {
        didSet{
            updateUi()
        }
    }
  
    
    @IBOutlet weak var tweetProfileNameLabel: UILabel!
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!

    func updateUI(){
        Tweet
    }
    
}
