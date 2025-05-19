import SwiftUI
func NextBig(num : Int) -> Int?{
    let inLetters = String(num)
    var listNums : [Int] = []
    for char in inLetters{
        if let newNum = Int(String(char)){
            listNums.append(newNum)
        }
    }
    listNums = listNums.sorted()
    var toReturn = 0
    for i in 0..<listNums.count{
        toReturn += listNums[i]*Int(pow(Double(10),Double(i)))
    }
    if toReturn==num{
        return nil
    }
    print(toReturn)
    return toReturn
}
var x=NextBig(num: 12221341209806986)