//
//  DetailViewController.swift
//  Twitter Client
//
//  Created by John Shaff on 10/19/16.
//  Copyright © 2016 John Shaff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet: Tweet!
    
    @IBOutlet weak var userLabel: UILabel!

    @IBOutlet weak var tweetText: UILabel!

   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        userLabel.text = tweet.user?.name
        tweetText.text = tweet.text
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
