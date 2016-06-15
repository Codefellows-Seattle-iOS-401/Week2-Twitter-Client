//
//  API.swift
//  twitterCustomer
//
//  Created by Jeremy Perez on 6/14/16.
//  Copyright © 2016 Jeremy Perez. All rights reserved.
//

import Foundation
import Accounts
import Social

class API {
    
    static let shared = API()
    
    var account: ACAccount?
    //Prompts Login and gets credentials
    private func login (completion: (account: ACAccount?) -> ()) {
        
        //accountStore is an instance of ACAccountStore object so that you can create and retrieve accounts from the Accounts database
        let accountStore = ACAccountStore()
        //Refers to the Twitter account type
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        //The user can grant access to their Twitter or not allow access
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) in
            
            //If user does not allow access; "_" is a placeholder to an unnamed constant because we won't use it again.
            if let _ = error {
                print("Error: Request access to account denied.")
                completion(account: nil)
                return
            }
            
            //If user grants access, make account equeal to the first account
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completion(account: account)
                    return
                }
            }
            
            //User grants access, but is not logged into account
            print("Error: You are not logged into a Twitter account.")
            completion(account: nil)
            return
        }
    }
    
    //The function takes a completion and the completion takes in an optional user.
    private func GETOAuthUser (completion: (user: User?) -> ()) {
        
        //request constant saves the path to the request object to be able to verify the user
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string:"https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        request.account = self.account
        
        //request.performRequestWith handler submits request for credentials.
        request.performRequestWithHandler { (data, response, error) in
            
            if let _ = error {
                print("Error: SLRequest type get for credentials could not be completed.")
                completion(user: nil)
                return
            }
            
            //If the response.statusCode comes back, unwrap the bundle and convert JSON data to be readable.
            switch response.statusCode {
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject] {
                        completion(user: User(json: userJSON))
                    }
                } catch {
                        print("Error: Count not serialize the JSON")
                        completion(user: nil)
                }
            case 400...499:
                print("Client Error statuscode \(response.statusCode)")
                completion(user: nil)
            case 500...599:
                print("Server Error statuscode \(response.statusCode)")
                completion(user: nil)
            default:
                print("Default case on the performRequestWithHandler status code")
                completion(user: nil)
            }
        }
    }
    
    //Once granted access and able to verify user, get the tweets
    private func updateTimeLine (completion: (tweets: [Tweet]?) -> ()) {
        
        //request constant saves the path to the tweets in the timeline
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        
        request.account = self.account
        
        //Makes a request to the timeline API
        request.performRequestWithHandler { (data, response, error) in
            
            if let _ = error {
                print("Error: SLRequest type get for user TimeLine could not be completed.")
                completion(tweets: nil)
                return
            }
            
            //If it successfully finds tweets, sets the information to be a tweet
            switch response.statusCode {
            case 200...299:
                JSONParser.tweetJSONFrom(data, completion: {(success, tweets) in dispatch_async(dispatch_get_main_queue(), { completion (tweets: tweets)
                    })
                })
            case 400...499:
                print("Client error statuscode \(response.statusCode)")
                completion(tweets: nil)
            case 500...599:
                print("Server error status code \(response.statusCode)")
                completion(tweets: nil)
            default:
                print("Default case on the updateTimeLine status code")
                completion(tweets: nil)
            }
        }
    }
    
    //getTweets is called in the ViewController and passes in the completion to the updateTimeLine for execution.
    func getTweets (completion: (tweets: [Tweet]?) -> ()) {
    
        if let _ = self.account {
            self.updateTimeLine(completion)
        } else {
            self.login({ (account) in
                if let account = account {
                API.shared.account = account
                    self.updateTimeLine(completion)
                } else {
                    print("Account is nil.")
                }
            })
        }
        
    }
}