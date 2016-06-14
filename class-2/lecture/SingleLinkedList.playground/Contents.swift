import UIKit

class Node<T> {
    let data: T
    var next: Node<T>?
    
    init(data: T) {
        self.data = data
    }
}

class LinkedList<T> {
    var head: Node<T>
    
    init(data: T) {
        self.head = Node(data: data)
    }
    
    func insert(data: T) {
        var current: Node<T>? = self.head
        
        while current?.next != nil {
            current = current?.next
        }
        current?.next = Node(data: data)
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
list.insert(2)
list.insert(3)
list.print()
list.count()

let stringList = LinkedList<String>(data: "hi")
stringList.insert("how")
stringList.insert("are you")

stringList.print()
stringList.count()

let opQueue = NSOperationQueue()
opQueue.addOperationWithBlock {
    print("This operation is added to our opQueue")
}


