//
//  ViewController.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/17/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit
import Accounts

class ViewController: UIViewController {
    
    //var currentAccount: ACAccount
    
    //outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func switchAccountButton(_ sender: AnyObject) {
        
        //switching between users via action sheet
            // Create action Sheet
            let actionSheetController: UIAlertController = UIAlertController(
                title: API.shared.accountList?.first as! String?,
                message: nil,
                preferredStyle: .actionSheet)
            
            let cancelAction: UIAlertAction = UIAlertAction(
                title: "Cancel",
                style: .cancel)
            { action -> Void in
                // Do nothing here
            }
            
            actionSheetController.addAction(cancelAction)
            // Loop over accounts
            for account in API.shared.accountList! {
                let aCAccount: ACAccount = account as! ACAccount
                var accountIdentifier = ""
                if aCAccount == API.shared.anAccount {
                    accountIdentifier = "✅ "
                }
                // in the block of the action tell it to change the API account & update the feed
                let selectAccounts: UIAlertAction = UIAlertAction(
                    title: accountIdentifier + "@" + aCAccount.username,
                    style: .default)
                { action -> Void in
                    API.shared.anAccount = aCAccount
                    self.updateFor(account: account as? ACAccount)
                }
                // add action to sheet for each account
                actionSheetController.addAction(selectAccounts)
            }
            //Present the AlertController
            self.present(actionSheetController, animated: true)
        }
    
    
    
//        let alertController = UIAlertController(title: nil, message: "Switch accounts", preferredStyle: .actionSheet)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//            //
//        }
//        alertController.addAction(cancelAction)
//        
//        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            //
//        }
//        alertController.addAction(OKAction)
//        
//        let destroyAction = UIAlertAction(title: "Destroy", style: .destructive) { (action) in
//            print(action)
//        }
//        alertController.addAction(destroyAction)
//        
//        self.present(alertController, animated: true) {
//            //
//        }
    
    
    //computed properties
    var allTweets = [Tweet]() {
        didSet { // didSet is a property observer, will fire off once complete
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up tableView height
        self.tableView.estimatedRowHeight = 75
        self.tableView.rowHeight = UITableViewAutomaticDimension
       
        //set up delegate and dataSoure
        tableView.delegate = self //concerned with user touch interactions
        tableView.dataSource = self //concerned with loading the tableView with info(has 2 required methods --> see extension below)
        
        //setup layout of tableView
        self.tableView.backgroundColor = UIColor.purple
        self.tableView.rowHeight = 100
        self.tableView.separatorColor = UIColor.green
        //self.tableView.widthAnchor.
        self.view.backgroundColor = UIColor.white
        
        
        if let account = API.shared.accountList?.first {
            updateFor(account: account as? ACAccount)
            API.shared.getTweetsForAccount(account: account as? ACAccount) { (tweets) in
                OperationQueue.main.addOperation {
                    if tweets != nil {
                        self.allTweets = tweets!
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showDetailSegue" {
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            let selectedTweet = self.allTweets[selectedIndex]
            
            if let destinationViewController = segue.destination as? DetailViewController {
                destinationViewController.tweet = selectedTweet
            }
        }
    }
    
    func updateFor(account: ACAccount?) {
        
        activityIndicator.startAnimating()
        
        API.shared.getTweetsForAccount(account: account) { (tweets) in
            if tweets != nil {
                //concurrency
                OperationQueue.main.addOperation { // taking assignment operation into the main queue
                    self.allTweets = tweets!
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//MARK: TableViewDataSource and TableViewDelegate Methods

// Best practice is to write your dataSource as an extension!!!

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //implement required methods for dataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell // casting as part of our custom subclass(TweetTableViewCell)
        let currentTweet = self.allTweets[indexPath.row] //assigning each tweet to its own row
        
        cell.contentView.backgroundColor = UIColor.purple
        
        cell.tweetLabelCell.text = currentTweet.text
        cell.tweetLabelCell.textColor = UIColor.white
        cell.tweetLabelCell.backgroundColor = UIColor.clear
        
        cell.detailTextLabel?.text = currentTweet.user?.name //subtitle input text
        cell.detailTextLabel?.textColor = UIColor.lightGray
        cell.detailTextLabel?.backgroundColor = UIColor.clear
        
        return cell
    }
    
    //delegate method(s)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

