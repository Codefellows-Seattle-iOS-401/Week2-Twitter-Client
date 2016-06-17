//
//  Cache.swift
//  TWTR
//
//  Created by hannah gaskins on 6/16/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import Foundation

class Cache<T: Hashable> { // the class needs to be Hashable bc it is generic and using the dict type that needs to be Hashable
    private var database: [String : T] // where we will store our keys and values
    private var transactions: [String]
    private let size: Int
    
    // when they call this, a need to specify how big it will be. 
    required init(size: Int) {
        
        self.database = Dictionary(minimumCapacity: size)
        self.transactions = [String]()
        self.size = size
        
    }
    
    func write(data: T, key: String) {
        if self.transactions.count < self.size {
            self.database[key] = data     ///// ???????????????????????????????????????????????
            self.transactions.append(key)
        } else {
            let top = self.transactions.removeFirst() // will remove 1st or top element in transction log. top is a key that we can use in the dict to remove values
            self.database.removeValueForKey(top) // our transaction log will be size - 1 (bc we remove one) and our database will be size - 1
            self.write(data, key: key)
        }
    }
    
    func read(key: String) -> T? {
        if let data = self.database[key], index = self.transactions.indexOf(key) {
            self.transactions.append(self.transactions.removeAtIndex(index))
            
            return data
        }
        return nil
    }
    
    
}