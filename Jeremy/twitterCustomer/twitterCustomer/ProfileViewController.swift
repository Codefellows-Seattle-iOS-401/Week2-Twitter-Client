//
//  ProfileViewController.swift
//  twitterCustomer
//
//  Created by Jeremy Perez on 6/15/16.
//  Copyright © 2016 Jeremy Perez. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

 
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.profileInfo()

    }
    
    func profileInfo() {
        API.shared.GETOAuthUser { (user) in
            if let user = user {
                self.userLabel.text = user.user
                self.locationLabel.text = user.location
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
