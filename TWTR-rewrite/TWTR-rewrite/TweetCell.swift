//
//  TweetCell.swift
//  TWTR-rewrite
//
//  Created by Erin Roby on 6/16/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var cache: Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            
            if let user = self.tweet.user {
                self.usernameLabel.text = user.screenName
                
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
    
    func setupTweetCell() {
        self.imgView.clipsToBounds = true
        self.imgView.layer.cornerRadius = 15.0
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
        self.layoutMargins = UIEdgeInsetsZero
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTweetCell()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
