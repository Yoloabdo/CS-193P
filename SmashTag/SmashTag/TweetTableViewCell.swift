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
            updateUI()
        }
    }
  
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetProfileNameLabel: UILabel!
    
    var hashtagColor = UIColor.blueColor()
    var urlColor = UIColor.darkGrayColor()
    var userMentionsColor = UIColor.grayColor()
    var dataTask: NSURLSessionDataTask?
    
 


    func updateUI(){
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetProfileNameLabel?.text = nil
        //tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet
        {
            
            
            let attributedText = NSMutableAttributedString(string: tweet.text!)
            attributedText.changeKeywordsColor(tweet.hashtags, color: hashtagColor)
            attributedText.changeKeywordsColor(tweet.urls, color: urlColor)
            attributedText.changeKeywordsColor(tweet.userMentions, color: userMentionsColor)
            tweetTextLabel?.attributedText = attributedText
            
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
          
            
            
            tweetProfileNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            // this let's you download the image everytime the cell is viewed, which is exhaustive for resources and doesn't cache as well.
//            if let profileImageURL = tweet.user.profileImageURL {
//                
//                let qos = Int(QOS_CLASS_DEFAULT.rawValue)
//                dispatch_async(dispatch_get_global_queue(qos, 0)){
//                    let imageData = NSData(contentsOfURL: profileImageURL)
//                    // blocks main thread!
//                    dispatch_async(dispatch_get_main_queue()){
//                        self.tweetProfileImageView?.image = UIImage(data: imageData!)
//                    }
//                }
//            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }
    }
    
}

private extension NSMutableAttributedString {
    func changeKeywordsColor(keywords: [Tweet.IndexedKeyword], color: UIColor) {
        for keyword in keywords {
            addAttribute(NSForegroundColorAttributeName, value: color, range: keyword.nsrange)
        }
    }
}

