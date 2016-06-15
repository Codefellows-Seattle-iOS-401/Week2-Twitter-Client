import UIKit

class Node<T> {
    let data: T
    var next: Node<T>?
    
    init(data: T) {
        self.data = data
    }
}

class LinkedList<T> {
    var head: Node<T> // pointer to the first node. you must have a head to start from!
    
    init(data: T) {
        self.head = Node(data: data)
    }
    
    func insertEnd(data: T) {
        var current: Node<T>? = self.head // when we start running, we start at the head so current is set to start here.
        
        while current?.next != nil {
            current = current?.next
        }
        current?.next = Node(data: data)
    }
    
    func reverse() {
        // in most cases your functions will have a copy of the head.
        var current: Node<T>? = self.head
        var previous: Node<T>?
        var next: Node<T>?
        
        while current != nil {
            next = current?.next
            current?.next = previous
            previous = current
            current = next
        }
        
        guard let prev = previous else { return }
        self.head = prev
    }
    
    func insert(data: T, index: Int) {
        var current: Node<T>? = self.head
        var count = 0
        var previous: Node<T>?
        
        if index <= self.count() {
            while current != nil {
                current = current?.next
                count += 1
                
                if count == index {
                    break
                }
                
                previous = current
            }
            
            let new = Node(data: data)
            previous?.next = new
            new.next = current
            
        } else {
            Swift.print("Out of bounds...")
        }
    }
    
    func print(){
        var current: Node<T>? = self.head
        
        while current != nil {
            Swift.print(current?.data)
            current = current?.next
        }
    }
    
    func count() -> Int {
        var current: Node<T>? = self.head
        var count = 0
        while current != nil {
            count += 1
            current = current?.next
        }
        return count
    }
}

let list = LinkedList<Int>(data: 1)
list.insertEnd(2)
list.insertEnd(3)
list.count()
list.insert(4, index: 2)
list.reverse()
list.print()

let stringList = LinkedList<String>(data: "hi")
stringList.insertEnd("how")
stringList.insertEnd("are you")

stringList.print()
stringList.count()

let opQueue = NSOperationQueue()
opQueue.addOperationWithBlock {
    print("This operation is added to our opQueue")
}

// Linked list = collection of nodes that holds data and a pointer to next link
// write a function the reverses a singlely linked list












































