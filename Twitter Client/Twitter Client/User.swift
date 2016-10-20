//
//  User.swift
//  Twitter Client
//
//  Created by John Shaff on 10/17/16.
//  Copyright © 2016 John Shaff. All rights reserved.
//

import Foundation

// This is a class Tweet type has to be initialized with a dictionary of mixed key value pairs. When it takes in that dictionary the initializing statement finds the key value pairs we want, and then assigns each pair to the declared properties: name, profileImageUrlString, location.

class User {
    let name: String
    let profileImageUrlString: String
    let location: String?
    
    init?(json: [String: Any]) {
        if let name = json["name"] as? String, let imageString = json["profile_image_url"] as? String {
            
            self.name = name
            self.profileImageUrlString = imageString
            self.location = json["location"] as? String
            
        } else {
            return nil
        }
    }
}
