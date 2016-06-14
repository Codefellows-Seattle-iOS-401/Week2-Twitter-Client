//
//  Users.swift
//  twitterCustomer
//
//  Created by Jeremy Perez on 6/13/16.
//  Copyright © 2016 Jeremy Perez. All rights reserved.
//

import Foundation

//Creates a class called user
class User
{
    //Creates the attributes necessary in a user instance
    let user: String
    let location: String
    let profileUrl: String
    
    //Initializer connects the user attributes to the attributes inside the JSON data
    init? (json: [String: AnyObject])
    {
        if let user = json["user"] as? String, location = json["location"] as? String, profileUrl = json["profile_image_url"] as? String
        {
            self.user = user
            self.location = location
            self.profileUrl = profileUrl
        }
        else
        {
            return nil
        }
    }
}