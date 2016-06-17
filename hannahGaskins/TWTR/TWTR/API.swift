//
//  API.swift
//  TWTR
//
//  Created by hannah gaskins on 6/14/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import Foundation
import Accounts
import Social

// declare 4 functions within API class
// 1. login and access function
// 2. Verification of credentials from login
// 3. update timeline
// 4. Get tweets and bring all functions together.

class API {
    
    
    static let shared = API()
    var account: ACAccount? // account variable to hold our information
    
    private func login(completion: (account: ACAccount?) -> ()) {
        // set up account store
        let accountStore = ACAccountStore()
        
        // give account store an account type of twitter
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: { (granted, error) -> Void in
            if let _ = error {
                print("ERROR: Request access to accounts returned an error.")
                completion(account: nil)
                return
            }
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completion(account: account)
                    return
                }
                // if no account was found
                print("ERROR: No twitter accounts were found on this device.")
                completion(account: nil)
                return
            }
            
            // if user did not grant access to account store for twitter accounts
            print("Error: This app requires access to the Twitter Accounts.")
            completion(account: nil)
            return
        })
        
    }
    
    func GETOAuthUser(completion: (user: User?) -> ()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            
            if let _ = error {
                print("Error: SLRequest type get for credentials could not be completed.")
                completion(user: nil)
                return
            }
            
            switch response.statusCode {
                
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject]{
                        print(userJSON)
                        completion(user: User(json: userJSON))
                    }
                } catch {
                    print("Error: Count not serialize the JSON")
                    completion(user: nil)
                }
                
            case 400...499:
                print("Client Error statuscode: \(response.statusCode)")
                completion(user: nil)
            case 500...599:
                print("Client Error statuscode: \(response.statusCode)")
                completion(user: nil)
            default:
                print("Default case on the status code")
                completion(user: nil)
                
            }
            
        }
    }
    
    private func updateTimeLine(urlString: String, completion: (tweets: [Tweet]?) -> ()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: urlString), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            
            if let _ = error {
                
                print("Error: SLRequest type get for user Timeline could not be completed.")
                completion(tweets: nil)
                return
            }
            
            switch response.statusCode {
                
            case 200...299:
                JSONParser.tweetJSONFrom(data, completion: { (success, tweets) in
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(tweets: tweets)
                    })
                })
            // same cases from GETOAuthUser switch statement for HTTP request codes
            case 400...499:
                print("Client Error statuscode: \(response.statusCode)")
                completion(tweets: nil)
            case 500...599:
                print("Server Error statuscode: \(response.statusCode)")
                completion(tweets: nil)
            default:
                print("Default case on the status code")
                completion(tweets: nil)
            }
        }
    }
    
    func getTweets(completion: (tweets: [Tweet]?) -> ()) {
        
        if let _ = self.account {
            // self.updateTimeLine(completion) // cancelled out for api
            self.updateTimeLine("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
        } else {
            
            self.login( { (account) -> () in
                
                if let account = account {
                    
                    // to set the account
                    API.shared.account = account
                    
                    // to make the tweets call
                    self.updateTimeLine("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
                } else {
                    print("Account is nil")
                }
            })
        }
        
    }
    
    // new function to get the individual user tweets and then use string interpolation at the end to add in their user name.
    
    func getUserTweets(username: String, completion: (tweets: [Tweet]?) -> ()) {
        self.updateTimeLine("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(username)", completion: completion)
    }
    
    // additional image function
    
    func getImage(urlString: String, completion:(image: UIImage) -> ()) {
        NSOperationQueue().addOperationWithBlock {
            // this is all we need to do to leave teh mainQueue
            // we need to convert URLstring -> URL -> NSData -> UIImage
            // add in a few guard statements
            guard let url = NSURL(string: urlString) else { return }
            guard let data = NSData(contentsOfURL: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            // now return on the mainQueue()
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completion(image: image)
            })

        }
    }
    
}








































