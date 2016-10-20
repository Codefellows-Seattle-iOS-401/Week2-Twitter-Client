//
//  DetailViewController.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/19/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(tweet.text)")
        print("\(tweet.user?.name)")
        
        usernameLabel.text = "@" + (tweet.user?.name)!
        tweetTextLabel.text = tweet.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "profileSegue" {
            segue.destination as! ProfileViewController
        }
    }
}
