//
//  Tweet.swift
//  Twitter Client
//
//  Created by John Shaff on 10/17/16.
//  Copyright © 2016 John Shaff. All rights reserved.
//

import Foundation

// This is a class Tweet type has to be initialized with a dictionary of mixed key value pairs. When it takes in that dictionary the initializing statement finds the key value pairs we want, and then assigns each pair to the declared properties: text, id, user.

class Tweet {
    let text: String
    let id: String
    let user: User?
    
    init?(jsonDictionary: [String: Any]) {
        if let text = jsonDictionary["text"] as? String, let id = jsonDictionary["id_str"] as? String, let userDict = jsonDictionary["user"] as? [String: Any] {
            
            self.id = id
            self.text = text
            self.user = User(json: userDict)
            
        } else {
            return nil
        }
    }
}





