//
//  TweetTableViewCell.swift
//  Twitter Client
//
//  Created by John Shaff on 10/19/16.
//  Copyright © 2016 John Shaff. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    //weak because storyboard contains only strong references
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            self.tweetText.text = tweet.text
            
            if let user = tweet.user {
                self.usernameLabel.text = user.name
                
                if let image = SimpleCache.shared.image(key: user.profileImageUrlString) {
                    userImageView.image = image
                    return
                }
                
                API.shared.getImageFor(urlString: user.profileImageUrlString, completion: { (image) in
                    if image != nil {
                        SimpleCache.shared.setImage(image!, key: user.profileImageUrlString)
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

        // Configure the view for the selected state
    }

}



