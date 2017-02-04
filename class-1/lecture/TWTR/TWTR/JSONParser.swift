//
//  JSONParser.swift
//  TWTR
//
//  Created by Michael Babiy on 6/13/16.
//  Copyright © 2016 Michael Babiy. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()

class JSONParser
{
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion)
    {
        do {
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String : AnyObject]] {
                
                var tweets = [Tweet]()
                
                for tweetJSON in rootObject {
                    if let tweet = Tweet(json: tweetJSON) {
                        tweets.append(tweet)
                    }
                }
                
                // Completion on success.
                completion(success: true, tweets: tweets)
            }
        }
        
        catch { completion(success: false, tweets: nil) }
    }
    
    class func JSONData() -> NSData
    {
        guard let tweeJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else { fatalError("JSON file does not exist.") }
        guard let tweetJSONData = NSData(contentsOfURL: tweeJSONPath) else { fatalError("Failed to convert JSON to data.") }
        return tweetJSONData
    }
}