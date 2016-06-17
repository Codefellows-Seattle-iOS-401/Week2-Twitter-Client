//
//  TweetCell.swift
//  TWTR
//
//  Created by hannah gaskins on 6/16/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    // reusing cache delegate code to access the cache: 
    
    var cache : Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    // passing in tweet from view controller. this function takes the tweet, username, and image and puts in in the outlet to display tweet, within the imageView of the TweetCell that we made with out TweetCell XIB. Any time this has been changed it mapped this information to the appropriate field
    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            if let user = self.tweet.user {
                self.userNameLabel.text = user.screenName
                
                if let image = cache?.read(user.profileImageUrl) {
                    self.imgView.image = image
                    return
                }
                
                API.shared.getImage(user.profileImageUrl, completion: { (image) in
                    
                    self.cache?.write(image, key: user.profileImageUrl)
                    self.imgView.image = image
                })
            }
        }
    }
    
    // formmating for the tweetCell ¯\_(ツ)_/¯
    
    func setupTweetCell(){
        self.imgView.clipsToBounds = true
        self.imgView.layer.cornerRadius = 15.0
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
        self.layoutMargins = UIEdgeInsetsZero
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTweetCell()
        // Initialization code
        
        //calling our formatting. instead of a segue from a veiw we "wake up the nibb" to get ready to use it. 
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
