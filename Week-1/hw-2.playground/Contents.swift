import Cocoa

var str = "hi Welcome to Swift hi Swift hi"

let result1 = str.components(separatedBy: "hi")
let result2 = str.components(separatedBy: "Welcome")
let result3 = str.components(separatedBy: "to")
let result4 = str.components(separatedBy: "Swift")

print("Hi : \(result1.count-1) times")
print("Welcome : \(result2.count-1) times")
print("to : \(result3.count-1) times")
print("Swift : \(result4.count-1) times")


