//
//  UIExtensions.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/20/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit


extension UIResponder {
    //will affect anything in UIKit
    class func identifier() -> String {
        return String(describing: self)
    }
}
