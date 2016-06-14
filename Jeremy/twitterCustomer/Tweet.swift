//
//  Tweet.swift
//  twitterCustomer
//
//  Created by Jeremy Perez on 6/13/16.
//  Copyright © 2016 Jeremy Perez. All rights reserved.
//

import Foundation

//Takes in an array of 3 dictionaries
class Tweet
{
    //Sets the necessary attributes text, id and user of the Tweet class
    let text: String
    let id: String
    let user: User?
    
    //Initialization connects the attributes created in the tweet class to the corresponding categories in the JSON file
    init? (json: [String: AnyObject])
    {
        if let text = json["text"] as? String, id = json["id_str"] as? String, user = json["user"] as? [String: AnyObject]
        {
            self.text = text
            self.id = id
            self.user = User(json: user)
        }
        else
        {
            return nil
        }
        
    }
}