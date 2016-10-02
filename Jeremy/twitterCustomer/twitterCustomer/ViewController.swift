//
//  ViewController.swift
//  twitterCustomer
//
//  Created by Jeremy Perez on 6/13/16.
//  Copyright © 2016 Jeremy Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var datasource = [Tweet]()
    {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "TWRT"
//        JSONParser.tweetJSONFrom(JSONParser.JSONData())
//        {
//            (success, tweets) in
//            if  success {
//                if let tweets = tweets {
//                    self.datasource = tweets
//                }
//            }
//        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
        self.setupTableView()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == DetailedViewController.id() {
            guard let detailViewController = segue.destinationViewController as? DetailedViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            
            detailViewController.tweet = self.datasource[indexPath.row]
        }
        
        
        
    }
    
    func setupTableView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func update() {

        API.shared.getTweets { (tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
//CREATE AN ELSE STATEMENT THAT CALLS THE LOGIN FUNCTION SO YOU CAN LOG IN TO OTHER ACCOUNTS. FOR EACH LOGIN, SET THE ACCOUNT TO THE API DATASOURCE SO YOU CAN SET A DIFFERENT ACCOUNT
        }
    }
    
    @IBAction func profileViewController(sender: AnyObject) {
        self.performSegueWithIdentifier("profileViewController", sender: nil)
    }

}

extension ViewController: UITableViewDataSource
{
    func tableView (tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView (tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //declare a reusable cell
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetcell", forIndexPath: indexPath)

        //configure the cell 
        cell.textLabel!.text = datasource[indexPath.row].text
        
        return cell
    }
}

