//
//  TweetTableViewCell.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/19/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
