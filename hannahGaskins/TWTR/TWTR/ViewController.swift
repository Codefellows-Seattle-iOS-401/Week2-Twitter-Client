//
//  ViewController.swift
//  TWTR
//
//  Created by hannah gaskins on 6/13/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var TableView: UITableView!
    
    // adding in cache call: 
    var cache : Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    
    var datasource = [Tweet]() {
        didSet {
            self.TableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.navigationItem.title = "TWTR"
        
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.update()
        
//        // make the call
//        JSONParser.tweetJSONFrom(JSONParser.JSONData()) { (success, tweets) in
//            if success {
//                if let tweets = tweets {
//                    self.datasource = tweets
//                }
//            }
//        }
    }
    
    func setupTableView() {
        self.TableView.estimatedRowHeight = 100
        self.TableView.rowHeight = UITableViewAutomaticDimension
        self.TableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "tweetCell") // nib name refers to class (uppercase), the lowercase is the cell label for reuse. bundle is nil bc we are in the same bundle
        self.TableView.delegate = self

    }
    
    
    
    func update()  {
        API.shared.getTweets { (tweets) -> () in
            if let tweets = tweets {
                self.datasource = tweets
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // everytime we move data we override this function
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailViewController.id() {
            guard let detailViewController = segue.destinationViewController as? DetailViewController else { return }
            guard let indexPath = self.TableView.indexPathForSelectedRow else { return }
            detailViewController.tweet = self.datasource[indexPath.row]
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // fire off above code prepForSegue here: 
        self.performSegueWithIdentifier(DetailViewController.id(), sender: nil)
    }

}
extension ViewController: UITableViewDataSource {
    func tableView(TableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(TableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        
        let tweet = self.datasource[indexPath.row]
        
        // we have to register the nib before we can use it. then within the tablView function in extention ViewController we force unwrap something
        
        cell.tweet = tweet
        
        return cell
    }
}













