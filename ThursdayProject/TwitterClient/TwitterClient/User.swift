//
//  User.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/17/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import Foundation


class User {
    let name: String
    let profileImageURLString: String
    let location: String?
    let screenName: String
    
    init?(json: [String : Any]) {
        if let name = json["name"] as? String, let profileImageURLString = json["profile_image_url_https"] as? String, let location = json["location"] as? String, let screenName = json["screen_name"] as? String {
            self.name = name
            self.profileImageURLString = profileImageURLString
            self.location = location
            self.screenName = screenName
        } else {
            return nil
        }
    }
}
