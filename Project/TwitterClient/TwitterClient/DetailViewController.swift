//
//  DetailViewController.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/19/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("User's name: \(tweet.user?.name)")
        print("Tweet text: \(tweet.text)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
