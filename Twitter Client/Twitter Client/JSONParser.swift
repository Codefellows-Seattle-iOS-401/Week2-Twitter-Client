//
//  JSONParser.swift
//  Twitter Client
//
//  Created by John Shaff on 10/17/16.
//  Copyright © 2016 John Shaff. All rights reserved.
//

import Foundation

typealias JSONParserHandler = (_ success: Bool, _ results: [Tweet]?) -> () //We're just storing a completion handler that takes in a function type

class JSONParser {
    
    //this is a DTC within a read-only computed property. This variable can later be called using dot syntax and computed on the spot to contain our JSON data. We're later going to call this variable to store the JSON data into an array.

    static var sampleJSONData: Data {
        
        guard let tweetJSONPath = Bundle.main.url(forResource: "Tweet", withExtension: ".json") else { fatalError ("There was an error accessing Tweet,json") }
        
        do {
            return try Data(contentsOf: tweetJSONPath)
        }
        catch {
            fatalError("Failed to convert Tweet.json to data.")
        }
    }
    
    
    
    class func tweetsFrom(data: Data, handler: JSONParserHandler) {
        
        do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                var tweets = [Tweet]()  //We're just storing a completion handler that takes
                
                for object in rootObject {
                    if let tweet = Tweet (jsonDictionary: object) {
                        tweets.append(tweet)
                    }
                }
        
                handler(true, tweets)

                
            }
            
        } catch {
            print ("Error Serializing JSON")
            handler(false, nil)
        }
    }
}
