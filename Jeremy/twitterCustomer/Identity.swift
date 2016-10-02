//
//  Identity.swift
//  twitterCustomer
//
//  Created by Jeremy Perez on 6/15/16.
//  Copyright © 2016 Jeremy Perez. All rights reserved.
//

import Foundation

protocol Identity
{
    static func id() -> String
    
}

extension Identity
{
    static func id() -> String {
        return String(self)
    }
}