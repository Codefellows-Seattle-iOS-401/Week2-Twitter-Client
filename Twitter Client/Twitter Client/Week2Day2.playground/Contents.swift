//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func yolo () {
    print("You only live once... unless you're Buddhist")
}

func master () {
    print("flex")
}

OperationQueue.main.addOperation {
    yolo()
    master()
}

