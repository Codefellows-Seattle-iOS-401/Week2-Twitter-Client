//
//  ViewController.swift
//  Twitter Client
//
//  Created by John Shaff on 10/17/16.
//  Copyright © 2016 John Shaff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func profileButton(_ sender: AnyObject) {
        
    }
    
    
    @IBOutlet weak var UIActivityIndicator: UIActivityIndicatorView!
    
    // This is an array that contains only class Tweet types
    var allTweets = [Tweet]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // viewDidLoad is a method of UIViewController and because we're creating a function that "overrides" that, we have to call the super to make sure everything loads. viewDidLoad is a life cycle method on the ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 75
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        update()
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showDetailSegue" {
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            let selectedTweet = self.allTweets[selectedIndex]
            
            //if this seque is going to the DetailViewController then select a tweet
            if let destinationViewController = segue.destination as? DetailViewController {
                destinationViewController.tweet = selectedTweet
            }
        }

    }
    
    class destinationViewController: DetailViewController {
        
    }
    
    
//    override func prepare(for segue: <#T##UIStoryboardSegue#>, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        
//        if segue.identifier == "showDetailDeque" {
//            let selectedIndex = tableView.indexPathForSelectedRow!.row
//            let selectedTweet = self.allTweets[selectedIndex]
//            
//            if let destinationViewController = segue.destination as DetailViewController {
//                destinationViewController.tweet = selectedTweet
//            }
//        }
//    }
    
    
    // everything in curly braces after getTweets is supposed to be the parameters of getTweets. Because getTweets was originally coded to take in a parameter of a function that has the signature of ([Tweet]?, String?) -> () then there has to be at least two placeholders in this closure to represent that signature even though those placeholders don't explicitly have value yet, and even though we're not using one of them.
    
    // We can access getTweets from here because it's a singleton
    
    
    func update() {
        
        UIActivityIndicator.startAnimating()
        
        API.shared.getTweets { (tweets, error) in
            if tweets != nil {
                OperationQueue.main.addOperation { () in
                    self.allTweets = tweets!
                    self.UIActivityIndicator.stopAnimating()
                    self.tableView.reloadData()
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetTableViewCell
        
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    let currentTweet = self.allTweets[indexPath.row]
        
        
    cell?.tweetText.text = currentTweet.text
    
        
    return cell!
        
    }
}
