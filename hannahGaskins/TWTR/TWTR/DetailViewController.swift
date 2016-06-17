//
//  DetailViewController.swift
//  TWTR
//
//  Created by hannah gaskins on 6/15/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    // adding in cache call:
    var cache : Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
//        if let tweet = self.tweet {
//            if let retweet = tweet.retweet {
//                self.tweetLabel.text = retweet.text
//                self.userLabel.text = retweet.user?.name
//            } else {
//                self.tweetLabel.text = tweet.text
//                self.userLabel.text = tweet.user?.name
//            }
//        }
    }
    
    
    func setUp() {
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user {
                self.navigationItem.title = "Retweet"
                self.tweetLabel.text = originalTweet.text
                self.userLabel.text = originalUser.name
                
                self.profileImage(originalUser.profileImageUrl, completion: { (image) in
                    self.profileImageView.image = image
                })
            } else {
                self.navigationItem.title = "Tweet"
                self.tweetLabel.text = tweet.text
                self.userLabel.text = user.name
                
                self.profileImage(user.profileImageUrl, completion: { (image) in
                    self.profileImageView.image = image
                })
            }
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == UserTimelineViewController.id() {
            guard let userTimelineViewController = segue.destinationViewController  as? UserTimelineViewController else { return }
            userTimelineViewController.tweet = self.tweet
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func profileImage(key: String, completion: (image: UIImage) -> ()) {
        if let image = cache?.read(key) {
            completion(image: image)
            return
        }
        API.shared.getImage(key) { (image) in
            self.cache?.write(image, key: key)
            completion(image: image)
            return
        }
    }
}
