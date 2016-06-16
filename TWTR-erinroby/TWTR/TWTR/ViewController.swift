//
//  ViewController.swift
//  TWTR
//
//  Created by Erin Roby on 6/13/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.navigationItem.title = "TWTR"
    }
    
    func setupTableView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
    }
    
    func update() {
        if let _ = API.shared.account {
            API.shared.getTweets { tweets in
                if let tweets = tweets {
                    self.datasource = tweets
                }
            }
        } else {
            API.shared.login({ (account) in
                if let accounts = account {
                    let controller = UIAlertController(title: "Accounts", message: "Please select an account.", preferredStyle: .ActionSheet)
                    
                    for account in accounts {
                        let action = UIAlertAction(title: account.username, style: .Default, handler: { (action) in
                            API.shared.account = account
                            API.shared.getTweets({[unowned self] tweets in
                                if let tweets = tweets {
                                    self.datasource = tweets
                                }
                                })
                        })
                        controller.addAction(action)
                    }
                    self.presentViewController(controller, animated: true, completion: nil)
                }
            })
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailViewController.id() {
            guard let detailViewController = segue.destinationViewController as? DetailViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            detailViewController.tweet = self.datasource[indexPath.row]
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath)
        let tweet = self.datasource[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        
        return cell
    }
}

