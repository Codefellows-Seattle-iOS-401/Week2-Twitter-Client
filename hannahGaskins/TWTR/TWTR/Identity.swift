//
//  Identity.swift
//  TWTR
//
//  Created by hannah gaskins on 6/15/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import Foundation

protocol Identity {
    static func id() -> String
}

extension Identity {
    static func id() -> String {
        return String(self)
    }
}