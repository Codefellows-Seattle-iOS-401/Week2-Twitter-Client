//
//  User.swift
//  TWTR
//
//  Created by Michael Babiy on 6/13/16.
//  Copyright © 2016 Michael Babiy. All rights reserved.
//

import Foundation

class User
{
    let name: String
    let profileImageUrl: String
    let location: String
    
    init?(json: [String : AnyObject])
    {
        if let name = json["name"] as? String, profileImageUrl = json["profile_image_url"] as? String, location = json["location"] as? String {
            self.name = name
            self.profileImageUrl = profileImageUrl
            self.location = location
        }
        
        else {
            return nil
        }
    }
}