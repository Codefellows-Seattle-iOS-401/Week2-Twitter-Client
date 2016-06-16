//
//  DetailedViewController.swift
//  twitterCustomer
//
//  Created by Jeremy Perez on 6/15/16.
//  Copyright © 2016 Jeremy Perez. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, Identity {

    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
            if let retweet = tweet?.retweet {
                self.tweetLabel.text = retweet.text
                self.usernameLabel.text = retweet.user?.user
            } else if let tweet = self.tweet {
                self.tweetLabel.text = tweet.text
                self.usernameLabel.text = tweet.user?.user
            }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
