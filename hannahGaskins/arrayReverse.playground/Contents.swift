//: Hannah Gaskins Array Reversal Function


var arrayOne:[Int] = [1, 2, 3]


func arrayReverse(input: [Int]) -> [Int] {
    var newArray = [Int]()
    for ii in 1...arrayOne.count{
        newArray = [arrayOne[arrayOne.count - ii]]
    }
    return newArray
}
arrayReverse([3, 2, 1])



