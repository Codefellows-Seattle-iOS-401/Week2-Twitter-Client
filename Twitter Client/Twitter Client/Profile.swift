//
//  Profile.swift
//  Twitter Client
//
//  Created by John Shaff on 10/19/16.
//  Copyright © 2016 John Shaff. All rights reserved.
//

import Foundation


class Profile {
    let name: String
    let profileImageUrlString: String
    let location: String?
    let followers_count: Int
    
    init?(json: [String: Any]) {
        print(json)
        if let name = json["name"] as? String, let imageString = json["profile_image_url"] as? String, let followers_count = json["followers_count"] as? Int {
            
            
            self.name = name
            self.profileImageUrlString = imageString
            self.location = json["location"] as? String
            self.followers_count = followers_count
            print(self)
            
        } else {
            return nil
        }
    }
}
