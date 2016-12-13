//
//  Profile.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/20/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import Foundation

class Profile {

    let profileImageString: String
    let profileName: String
    let userName: String
    let location: String?
    let description: String
    let followerCount: Int?
    
    init(profileImageString: String, profileName: String, userName: String, location: String?, description: String, followerCount: Int?) {
        self.profileImageString = profileImageString
        self.profileName = profileName
        self.userName = userName
        self.location = .json["location"] as? String
        self.followerCount = followerCount
        print(self)
    }
}
