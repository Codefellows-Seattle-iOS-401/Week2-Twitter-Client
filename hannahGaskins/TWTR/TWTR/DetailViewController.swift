//
//  DetailViewController.swift
//  TWTR
//
//  Created by hannah gaskins on 6/15/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {
    
    @IBOutlet weak var userLabel: UILabel!
    var tweet: Tweet?

    @IBOutlet weak var tweetLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            if let retweet = tweet.retweet {
                self.tweetLabel.text = retweet.text
                self.userLabel.text = retweet.user?.name
            } else {
                self.tweetLabel.text = tweet.text
                self.userLabel.text = tweet.user?.name
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
