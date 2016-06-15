//
//  ViewController.swift
//  twitterCustomer
//
//  Created by Jeremy Perez on 6/13/16.
//  Copyright © 2016 Jeremy Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //creates a connection to the table view
    @IBOutlet weak var tableView: UITableView!
    
    //Didset says theres new data on any data type and .reloadData reloads tableview
    var datasource = [Tweet]()
    {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //takes the data from the JSONData() and converts it into readable data using .tweetJSONfrom(). If it does complete these methods takes in
    override func viewDidLoad() {
        super.viewDidLoad()
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

    
    //Updates datasource with tweets from API just when you open a window.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.update()
        
    }
    
    func update() {
        API.shared.getTweets { (tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
        }
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

