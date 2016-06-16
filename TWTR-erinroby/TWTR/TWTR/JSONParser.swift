//
//  JSONParser.swift
//  TWTR
//
//  Created by Erin Roby on 6/13/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()


class JSONParser {
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion) {
        do {
            if let rootTweet = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String: AnyObject]] {
                var tweets = [Tweet]()
                
                for tweetJSON in rootTweet {
                    if let tweet = Tweet(json: tweetJSON) {
                        tweets.append(tweet)
                    }
                }
                completion(success: true, tweets: tweets)
            }
        }
        catch {
            completion(success: false, tweets: nil)
        }
    }
    
//    class func JSONData() -> NSData {
//        guard let tweetJSONPath =  NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else { fatalError("Tweet.json does not exist") }
//        
//        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath) else {
//            fatalError("Failed to convert data") }
//        
//        return tweetJSONData
//    }
}

