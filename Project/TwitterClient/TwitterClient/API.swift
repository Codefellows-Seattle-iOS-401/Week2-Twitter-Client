//
//  API.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/18/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import Foundation
import Accounts
import Social

//account completion
typealias accountCompletion = ([ACAccount]?) -> ()
typealias userCompletion = (User?) -> ()
typealias tweetsCompletion = ([Tweet]?) -> ()


class API {
    //singleton
    static let shared = API()
    
    //global vars
    var anAccount: ACAccount?
    //create array for twitter accounts
    var accountList: [Any]?
    
    //private funcs
    private func login(completion: @escaping accountCompletion) {
        //implement accounts framework workflow
        
        let accountStore = ACAccountStore() //get instance of account store
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter) //get instance of account type
        
        //specify account store to request access to accounts
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            if error != nil {
                print("ERROR requesting access to your twitter account!")
                completion(nil)
            }
            if success {
                self.accountList = accountStore.accounts(with: accountType!)
                
                if let anAccount = self.accountList?.first as? [ACAccount] {
                    completion(anAccount)
                    dispatchMain()
                }
            } else {
                print("UNSUCCESSFUL: because no twitter accounts logged in on the device")
                completion(nil)
            }
        }
        
    }
    
    //Grab resource URL to verify account credentials with server(rest API),
    private func getOAuthUser(completion: @escaping userCompletion) {
        let url = URL(string: "https://api.twitter.com/1.1/account/verfiy_credentials.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                   requestMethod: .GET,
                                   url: url,
                                   parameters: nil) {
            request.account = self.anAccount
            
            request.perform(handler: { (data, response, error) in
                if error != nil {
                    print("ERROR accessing Twitter to verify credentials")
                    completion(nil)
                }
                guard data != nil else { completion(nil); return }
                guard response != nil else { completion(nil); return }
                
                switch response!.statusCode {
                case 200...299:
                    print("OK")
                    do {
                        //JSON that comes back from user credentials
                        if let userJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                            completion(User(json: userJSON))
                        }
                    } catch {
                        print("ERROR: Cannot serialize data")
                    }
                case 400...499:
                    print("\(response!.statusCode): Client-Side ERROR")
                case 500...599:
                    print("\(response!.statusCode): Server-Side ERROR")
                default:
                    print("Unrecognized status code")
                }
                completion(nil)
            })
        }
    }
    
    
    
    private func updateTimelineFor(account: ACAccount, completion: @escaping tweetsCompletion) {
        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                   requestMethod: .GET,
                                   url: url,
                                   parameters: nil) {
            request.account = account
            
            request.perform(handler: { (data, response, error) in
                if error != nil {
                    print("ERROR: fetching home timeline")
                    completion(nil)
                }
                guard response != nil else { completion(nil); return }
                guard data != nil else { completion(nil); return }
                
                switch response!.statusCode {
                case 200...299:
                    print("OK")
                    JSONParser.tweetsFrom(data: data!, completion: { (success, tweets) in
                        if success {
                            completion(tweets)
                        }
                        completion(nil)
                    })
                case 400...499:
                    print("\(response!.statusCode): Client-Side ERROR")
                case 500...599:
                    print("\(response!.statusCode): Server-Side ERROR")
                default:
                    print("Response came back with unrecognized status code")
                }
                completion(nil)
            })
        }
    }
    // *refactor above 2 functions into one function! *
    
    //accessor method for tweets
    func getTweetsForAccount(account: ACAccount?, completion: @escaping tweetsCompletion) {
        if account != nil && self.accountList != nil {
            self.updateTimelineFor(account: account!, completion: completion)
        }
        self.login { (anAccount) in
            if self.accountList != nil {
                API.shared.accountList = self.accountList
                self.updateTimelineFor(account: self.accountList!.first! as! ACAccount, completion: completion)
            }
            completion(nil)
        }
    }
}





