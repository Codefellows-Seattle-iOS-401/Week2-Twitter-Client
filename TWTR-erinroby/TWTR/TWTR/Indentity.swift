//
//  Indentity.swift
//  TWTR
//
//  Created by Erin Roby on 6/15/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
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