//
//  Tweet.swift
//  TWTR-rewrite
//
//  Created by Erin Roby on 6/16/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

class Tweet {
    let text: String
    let id: String
    let user: User?
    var retweet: Tweet?
    
    init?(json: [String: AnyObject]) {
        if let text = json["text"] as? String, id = json["id_str"] as? String, user = json["user"] as? [String: AnyObject] {
            self.text = text
            self.id = id
            self.user = User(json: user)
            
            if let retweetJSON = json["retweeted_status"] as? [String: AnyObject] {
                if let retweet = Tweet(json: retweetJSON) {
                    self.retweet = retweet
                }
            }
        } else {
            return nil
        }
    }
}
