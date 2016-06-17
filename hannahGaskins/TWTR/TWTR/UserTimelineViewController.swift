//
//  UserTimelineViewController.swift
//  TWTR
//
//  Created by hannah gaskins on 6/16/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource, Identity {

    @IBOutlet weak var tableView: UITableView!
    
    var tweet: Tweet?
    var tweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpTableView()

        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user {
                self.navigationItem.title = originalUser.name
                self.update(originalUser.screenName)
            } else {
                self.navigationItem.title = user.screenName
                self.update(user.screenName)
            }
            
        }
        
    }
    
    
    func update(screenname: String){
        API.shared.getUserTweets(screenname) { (tweets) in
            guard let tweets = tweets else { return }
            self.tweets = tweets
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTableView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
        self.tableView.dataSource = self
    }
    
    
}

extension UserTimelineViewController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tweetCell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        
        tweetCell.tweet = self.tweets[indexPath.row]
        
        return tweetCell
    }
}
