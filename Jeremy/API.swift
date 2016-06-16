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

//MAKE THIS PRIVATE FUNCTION PUBLIC SO YOU CAN CALL IT IN THE ViewController.swift file
    private func login (completion: (account: ACAccount?) -> ()) {

        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) in
            
            if let _ = error {
                print("Error: Request access to account denied.")
                completion(account: nil)
                return
            }
            
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completion(account: account)
                    return
                }
            }
            
            print("Error: You are not logged into a Twitter account.")
            completion(account: nil)
            return
        }
    }
    
    func GETOAuthUser (completion: (user: User?) -> ()) {

        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string:"https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
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
    
    private func updateTimeLine (completion: (tweets: [Tweet]?) -> ()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            
            if let _ = error {
                print("Error: SLRequest type get for user TimeLine could not be completed.")
                completion(tweets: nil)
                return
            }
            
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