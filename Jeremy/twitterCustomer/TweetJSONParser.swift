//
//  TweetJSONParser.swift
//  twitterCustomer
//
//  Created by Jeremy Perez on 6/13/16.
//  Copyright © 2016 Jeremy Perez. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()

class JSONParser {

    class func tweetJSONFrom (data: NSData, completion: JSONParserCompletion)
    {
        do {
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String: AnyObject]]
            {
                var tweets = [Tweet]()
                
                for tweet in rootObject
                {
                    if let tweet = Tweet(json: tweet)
                    {
                        tweets.append(tweet)
                    }
                }
                completion(success: true, tweets: tweets)
            }
        } catch
        {
                completion(success: false, tweets: nil)
        }
    }
    

    class func JSONData() -> NSData
    {
        guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json")
            else
            {
                fatalError("Did not find path to JSON data")
            }
        
        //saves the data found in tweetJSONPath as contents of url
        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath)
            else
            {
            fatalError("Did not get JSON Data for tweet class")
            }
        
        return tweetJSONData
    }
}