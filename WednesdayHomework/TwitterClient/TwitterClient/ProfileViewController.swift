//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/19/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var description: UILabel!
    
    var currentProfile: Profile?

    override func viewDidLoad() {
        super.viewDidLoad()

        API.shared.getCurrentUser { (currentProfile, error) in
            self.currentProfile = currentProfile
            OperationQueue.main.addOperation {
                self.userLocation.text = self.currentProfile?.location
            }
        }
        userName.text = API.shared.account?.username
        //userLocation.text = API.shared.account?
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
