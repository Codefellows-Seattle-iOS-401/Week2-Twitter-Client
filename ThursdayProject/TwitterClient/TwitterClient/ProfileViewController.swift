//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/19/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var myProfileImage: UIImageView!
    @IBOutlet weak var myUsernameLabel: UILabel!
    @IBAction func dismissModalViewAction(_ sender: AnyObject) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
