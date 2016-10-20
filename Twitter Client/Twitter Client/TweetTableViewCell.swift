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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



