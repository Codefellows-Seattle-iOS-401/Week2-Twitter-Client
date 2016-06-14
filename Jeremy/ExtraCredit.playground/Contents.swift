//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

var sampleArray1 = ["eat", "drink", "sleep"]
var sampleArray2 = [ 1, 2, 3, 4, 5]

func reverseArray(string: [AnyObject]) -> [AnyObject]
{
    var reverse = [AnyObject]()
    for element in string {
        reverse.insert(element, atIndex: 0)
    }
    return reverse
}

var new1 = reverseArray(sampleArray1)
var new2 = reverseArray(sampleArray2)

