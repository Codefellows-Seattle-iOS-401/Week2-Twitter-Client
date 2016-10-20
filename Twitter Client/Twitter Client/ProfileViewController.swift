//
//  ProfileViewController.swift
//  Twitter Client
//
//  Created by John Shaff on 10/19/16.
//  Copyright © 2016 John Shaff. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userLocation: UILabel!
    
    var currentProfile: Profile?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sending a call to the server so need to add to Que
        API.shared.getCurrentUser { (currentProfile, error) in
            self.currentProfile = currentProfile
            OperationQueue.main.addOperation {
                self.userLocation.text = self.currentProfile?.location
            }
        }
        
        userName.text = API.shared.account?.username
        
    }

    @IBAction func exitButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
