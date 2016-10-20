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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = API.shared.account?.username
        
//        userLocation.text = API.shared.account?
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
