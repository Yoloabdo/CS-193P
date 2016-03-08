//
//  TweetDetailsTableViewController.swift
//  SmashTag
//
//  Created by abdelrahman mohamed on 3/5/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class TweetDetailsTableViewController: UITableViewController {

    
    var tweet: Tweet?{
        didSet{
            title = tweet?.user.screenName
            if let media = tweet?.media {
                tableDetails.append(tweetStruct(title: "Media",
                    data: [tweetItem.media(media)]))
            }
            if let urls = tweet?.urls {
                tableDetails.append(tweetStruct(title: "URLs",
                    data: urls.map { tweetItem.Keyword($0.keyword) }))
            }
            if let hashtags = tweet?.hashtags {
                tableDetails.append(tweetStruct(title: "Hashtags",
                    data: hashtags.map { tweetItem.Keyword($0.keyword) }))
            }
            if let users = tweet?.userMentions {
                //Showing the user who posted the tweet.
                var userItems = [tweetItem.Keyword("@" + tweet!.user.screenName)]
                if users.count > 0 {
                    userItems += users.map { tweetItem.Keyword($0.keyword) }
                }
                tableDetails.append(tweetStruct(title: "Users", data: userItems))
            }
        }
    }
    
    var tableDetails:[tweetStruct] = []
    var colliModel = [MediaItem]()

    enum tweetItem: CustomStringConvertible{
        case Keyword(String)
        case media([MediaItem])
        
        var description: String {
            switch self {
            case .Keyword(let keyword): return keyword
            case .media(_): return "Media"
            }
        }

    }
    
    struct tweetStruct: CustomStringConvertible {
        var title: String
        var data: [tweetItem]
        var description: String { return "\(title): \(data)" }

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.detailsSession = NSURLSession(configuration: config)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableDetails.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableDetails[section].data.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableDetails[section].title
    }

    struct StoryBoard {
        static let KeywordCellReuseIdentifier = "textCell"
        static let imageCellReuseIdentifier = "imageCell"
        static let collictionReuseCellIdentfier = "collictionCell"
        static let zoomedImageIdentfier = "imageViewZoomed"
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let rowDetail = tableDetails[indexPath.section].data[indexPath.row]
        switch rowDetail {
        case .Keyword(let keyWord):
            let cell = tableView.dequeueReusableCellWithIdentifier(
                StoryBoard.KeywordCellReuseIdentifier,
                forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = keyWord
            return cell
        
        case .media(let med):
            let cell = tableView.dequeueReusableCellWithIdentifier(
                StoryBoard.collictionReuseCellIdentfier,
                forIndexPath: indexPath) as! collictionCell
            
                colliModel = med
            
            return cell
       
        }
        

    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? collictionCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    

 
    private var detailsSession: NSURLSession!


}

// extinsion in order to view images in the colliction view cell. 

extension TweetDetailsTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            
            return colliModel.count
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let sender = sender as? MediaCollectionViewCell {
            if segue.identifier == StoryBoard.zoomedImageIdentfier {
                let ivc = segue.destinationViewController as! ImageViewController
                ivc.image = sender.imageView?.image
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StoryBoard.imageCellReuseIdentifier,
                forIndexPath: indexPath) as! MediaCollectionViewCell
            
            if Reachability.isConnectedToNetwork(){
                let request = NSURLRequest(URL: colliModel[indexPath.row].url)
                print(request)
                cell.dataTask = self.detailsSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        if let error = error {
                            print(error)
                        }
                        if let data = data {
                            let image = UIImage(data: data)
                            if let imageCell = cell.imageView {
                                imageCell.image = image
                            }
                            
                        }
                    })
                }
                
                
                cell.dataTask?.resume()

            }else{
                print("connection failed")
            }
            
            return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? MediaCollectionViewCell {
            cell.dataTask?.cancel()
        }

    }
}