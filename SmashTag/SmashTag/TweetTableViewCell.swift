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
    var profileImage: UIImage? {
        didSet{
            tweetProfileImageView?.image = profileImage
        }
    }
    
 


    func updateUI(){
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetProfileNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = tweet
        {
            
            
            let attributedText = NSMutableAttributedString(string: tweet.text!)
            attributedText.changeKeywordsColor(tweet.hashtags, color: hashtagColor)
            attributedText.changeKeywordsColor(tweet.urls, color: urlColor)
            attributedText.changeKeywordsColor(tweet.userMentions, color: userMentionsColor)
            
            
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            tweetTextLabel?.attributedText = attributedText
            
            
            tweetProfileNameLabel?.text = "\(tweet.user)" // tweet.user.description
            tweetProfileImageView.image = profileImage
            
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

