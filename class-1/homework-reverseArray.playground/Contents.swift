//: Playground - noun: a place where people can play

import UIKit


func reverseArray(array: [AnyObject]) -> [AnyObject] {
    
    return array.reverse()
    
}

var firstArray = [1,2,3,4,5,6]
var secondArray = ["tre", "mike", "derek"]

reverseArray(firstArray)
reverseArray(secondArray)
