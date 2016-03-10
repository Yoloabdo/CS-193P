//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by abdelrahman mohamed on 2/25/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate
{
    // MARK: - Public API

    var tweets = [[Tweet]]()

    var searchText: String? {
        didSet {
            lastSuccessfulRequest = nil
            searchTextField?.text = searchText
            tweets.removeAll()
            tableView.reloadData() // clear out the table view
            refresh()
            
        }
    }
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        refresh()
    }
    
    // MARK: - Refreshing

    private var lastSuccessfulRequest: TwitterRequest?

    private var nextRequestToAttempt: TwitterRequest? {
        if lastSuccessfulRequest == nil {
            if let searchText = searchText {
                history.addWord(searchText)
                return TwitterRequest(search: searchText, count: 100)
            } else {
                return nil
            }
        } else {
            return lastSuccessfulRequest!.requestForNewer
        }
    }
    var numRows = true
    
    
    @IBAction private func refresh(sender: UIRefreshControl?) {
        if Reachability.isConnectedToNetwork(){
            numRows = true
            if let request = nextRequestToAttempt {
                request.fetchTweets { (newTweets) -> Void in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        if newTweets.count > 0 {
                            self.lastSuccessfulRequest = request // oops, forgot this line in lecture
                            self.tweets.insert(newTweets, atIndex: 0)
                            self.tableView.reloadData()
                        }
                        sender?.endRefreshing()
                    }
                }
            } else {
                sender?.endRefreshing()
            }
        }else{
            let alert = UIAlertController(title: "Connection failed", message: "check your internet connection", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { _ in
                sender?.endRefreshing()}))
            alert.addAction(UIAlertAction(title: "Try again", style: .Default, handler: { _ in
                self.refresh()
            }))
            presentViewController(alert, animated: true, completion: nil)
            numRows = false
        }
    }
    
    func refresh() {
        refreshControl?.beginRefreshing()
        refresh(refreshControl)
    }
    
    
    // MARK: - Rresistance
    
    let history = PrestingHistory()
    
    // MARK: - Storyboard Connectivity
    
    @IBOutlet private weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text
        }
        return true
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier = "Tweet"
        static let segue = "cellDetail"
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if numRows {
            return tweets[section].count
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! TweetTableViewCell

        let tweet = tweets[indexPath.section][indexPath.row]
        
        if Reachability.isConnectedToNetwork() {
            if let url = tweet.user.profileImageURL {
                let request = NSURLRequest(URL: url)
                
                cell.dataTask = urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        if error == nil && data != nil {
                            let image = UIImage(data: data!)
                            cell.profileImage = image
                        }
                    })
                }
                cell.dataTask?.resume()
            }
        }
        
        cell.tweet = tweet
        return cell
    }
    
    // MARK: - NSURLSession 
    private var urlSession: NSURLSession!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.urlSession = NSURLSession(configuration: config)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        urlSession.invalidateAndCancel()
        urlSession = nil
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? TweetTableViewCell {
            cell.dataTask?.cancel()
            cell.dataTask = nil
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.segue{
            let tvc = segue.destinationViewController as! TweetDetailsTableViewController
            let cell = sender as! TweetTableViewCell
            if let indexPath = tableView.indexPathForCell(cell){
                tvc.tweet = tweets[indexPath.section][indexPath.row]
            }

        }
    }
    
    @IBAction func goBackToSearch(segue: UIStoryboardSegue){
    
    }

}
