//
//  API.swift
//  Twitter Client
//
//  Created by John Shaff on 10/18/16.
//  Copyright © 2016 John Shaff. All rights reserved.
//

import Foundation
import Accounts
import Social

// What is the purpose of typealiasing

typealias accountCompletion = (ACAccount?, String?) -> ()
typealias userCompletion = (User?, String?) -> ()
typealias tweetsCompletion = ([Tweet]?, String?) -> ()


class API {
    static let shared = API ()
    
    var account : ACAccount?
    var userProfile: ACAccount?
    
    private func login (completion: @escaping accountCompletion) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter) // Apple has already given us a constant for this.
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            if error != nil {
                print("ERROR: Requesting access to Twitter account")
                completion(nil, "Sorry Charlie")
            }
            
            if success {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                    completion(account, "Sorry Charlie")
                    
                } else {
                    print("UNSUCCESSFUL: No Twitter Accounts found on device.")
                    completion(nil, "Sorry Charlie")
                }
            }
        }
        
    }
    
    private func getOAuthUser (completion: @escaping userCompletion) {
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, url: url, parameters: nil) {
            
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                if error != nil {
                    print("Error accessing Twitter to verify credentials.")
                    completion(nil, "Sorry Charlie")
                }
                
                guard response != nil else { completion(nil, "Sorry Charlie"); return }
                guard data != nil else { completion(nil, "Sorry Charlie"); return }
                
                switch response!.statusCode {
                case 200...299:
                    do {
                        if let userJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                            completion(User(json: userJSON), "Sorry Charlie")
                        }
                    } catch {
                        print("Error cannot serialize data")
                    }
                case 400...499:
                    print("\(response!.statusCode): Client Side Error")
                case 500...599:
                    print("\(response!.statusCode): Client Side Error")
                    default:
                        print("Unrecognized Status Code")
                }
                completion(nil, "Sorry Charlie")
            })
        }
    }
    
    
    private func updateTimeLine (completion: @escaping tweetsCompletion) {
        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        if let request = SLRequest(
            forServiceType: SLServiceTypeTwitter,
            requestMethod: .GET,
            url: url,
            parameters: nil) {
        
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                if error != nil {
                    print("Error: fetching home timeline")
                    completion(nil, "Sorry Charlie")
                }
                
                guard response != nil else { completion(nil, "Sorry Charlie"); return }
                guard data != nil else { completion(nil, "Sorry Charlie"); return }
                
                switch response!.statusCode {
                case 200...299:
                    JSONParser.tweetsFrom(data: data!, handler: { (success, tweets) in
                        if success {
                            completion(tweets, "Sorry Charlie")
                        }
                        completion(nil, "Sorry Charlie")
                    })
                case 400...499:
                    print("\(response!.statusCode): Client Side Error")
                case 500...599:
                    print("\(response!.statusCode): Client Side Error")
                    default:
                        print("Unrecognized Status Code")
                }
            })
        }
    }
    
    
    func getTweets (completion: @escaping tweetsCompletion) {
        if self.account != nil {
            self.updateTimeLine(completion: completion)
        }
        
        self.login { (account, error) in
            if account != nil {
                self.account = account!
                self.updateTimeLine(completion: completion)
            }
            completion(nil, "Sorry Charlie")
        }
    }
    
    
    //NOT FINISHED YET:
//    func getCurrentUser (callback: @escaping userCompletion) {
//        if self.account != nil {
//            let userProfile = Profile(json: [String : Any])
//        }
//    }
}
