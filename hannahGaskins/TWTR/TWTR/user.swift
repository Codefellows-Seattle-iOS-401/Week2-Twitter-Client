//
//  user.swift
//  TWTR
//
//  Created by hannah gaskins on 6/13/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import Foundation

class User {
    let name: String
    let profileImageUrl: String
    let location: String
    // adding in screenName for individual user's names and then initialize
    let screenName: String
    
    init?(json: [String : AnyObject]) {
        if let name = json["name"] as? String, profileImageUrl = json["profile_image_url"] as? String, location = json["location"] as? String, screenName = json["screen_name"] as? String {
            
            self.name = name
            self.profileImageUrl = profileImageUrl
            self.location = location
            self.screenName = screenName
            
            
        } else {
            return nil
        }
    }
    
}