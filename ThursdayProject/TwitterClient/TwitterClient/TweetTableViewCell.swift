//
//  TweetTableViewCell.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/19/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            if let user = tweet.user {
                self.usernameLabel.text = user.screenName
                
                if let image = SimpleCache.shared.image(key: user.profileImageURLString) {
                    userImageView.image = image
                    return
                }
                API.shared.getImageFor(urlString: user.profileImageURLString, completion: { (image) in
                    if image != nil {
                        SimpleCache.shared.setImage(image!, key: user.profileImageURLString)
                        self.userImageView.image = image!
                    }
                })
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
