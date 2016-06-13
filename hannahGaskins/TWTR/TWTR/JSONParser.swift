//
//  JSONParser.swift
//  TWTR
//
//  Created by hannah gaskins on 6/13/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()

class JSONParser {
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion) {
        do {
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String : AnyObject]] {
                var tweets = [Tweet]()
                
                for tweetJSON in rootObject {
                    if let tweet = Tweet(json: tweetJSON) {
                        tweets.append(tweet)
                    }
                }
            }
        }
        catch { completion(success: false, tweets: nil) }
    }
    class func JSONData() -> NSData {
        guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else { fatalError("JSON file does not exist") }
        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath) else { fatalError("Failed to convert JSON to data") }
        return tweetJSONData
    }
}