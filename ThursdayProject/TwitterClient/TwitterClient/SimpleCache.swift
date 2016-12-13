//
//  SimpleCache.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/20/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit


class SimpleCache {
    //create singleton
    static let shared = SimpleCache()

    private var cache = [String: UIImage]()
    
    private let capacity = 20
    
    // to access cache...accessor method to get image
    func image(key: String) -> UIImage? {
        return self.cache[key]
    }
    //put image into cache...
    func setImage(_ image: UIImage, key: String) {
        //manage capacity
        if self.cache.count >= capacity {
            //grab random image to free up space for new image into cache
            guard let randomKeyDelete = Array(self.cache.keys).last else { return }
            self.cache.removeValue(forKey: randomKeyDelete)
        }
        self.cache[key] = image
    }
}
