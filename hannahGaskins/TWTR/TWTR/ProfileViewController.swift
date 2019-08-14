//
//  ProfileViewController.swift
//  TWTR
//
//  Created by hannah gaskins on 6/15/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserLocation: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        API.shared.GETOAuthUser { (user) in
            if let user = user {
                self.user = user
                // callback with user name. A calback is automatically running on the background thread and we need to change UI labels to main thread
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    
                    self.UserName.text = self.user?.name
                    self.UserLocation.text = self.user?.location
                   
                    if let url = NSURL(string: (self.user?.profileImageUrl)!) {
                        let data = NSData(contentsOfURL: url)
                        self.userImage.image = UIImage(data: data!)
                    }
                    
                })
                
                
            }
        }

        
        
    }
    @IBAction func closeButtonSelected(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
