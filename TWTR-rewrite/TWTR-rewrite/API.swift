//
//  API.swift
//  TWTR-rewrite
//
//  Created by Erin Roby on 6/16/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import Foundation
import Accounts
import Social

class API {
    static let shared = API()
    var account: ACAccount?
    
    func login(completion: (account: ACAccount?) -> ()) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: { (granted, error) -> Void in
            if let _ = error {
                print(error.localizedDescription)
                completion(account: nil)
                return
            }
            
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(account: account)
                        return
                    })
                }
 
                print("ERROR: No twitter accounts were found on this device.")
                completion(account: nil)
                return
            }

            print("Error: This app requires access to the Twitter Accounts.")
            completion(account: nil)
            return
        })
    }
    
    func GETOAuthUser(completion: (user: User?) -> ()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod:.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
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
                print("Server Error statuscode: \(response.statusCode)")
                completion(user: nil)
                
            default:
                print("Default case on the status code")
                completion(user: nil)
            }
        }
    }
    
    private func updateTimeline(urlString: String, completion: (tweets: [Tweet]?) -> ()) {
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
    
    func GETTweets(completion: (tweets: [Tweet]?) -> ()) {
        self.updateTimeline("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
    }
    
    func getUserTweets(screenName: String, completion: (tweets: [Tweet]?) -> ()) {
        self.updateTimeline("https://api.twitter.com/1.1/statuses/home_timeline.json?screen_name=\(screenName)", completion: completion)
    }
    
    func getImage(urlString: String, completion:(image: UIImage)->()) {
        NSOperationQueue().addOperationWithBlock {
            guard let url = NSURL(string: urlString) else { return }
            guard let data = NSData(contentsOfURL: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completion(image: image)
            })
        }
    }
}


