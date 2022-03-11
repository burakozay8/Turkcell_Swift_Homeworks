import Cocoa

let number:Int = 1
var start = 0
var next = 1
var sum = 0

while next < 4000000 {
     let aux = start + next
     start = next
     next = aux
    
    if next % 2 == 0 {
        sum += next
    }
}

print(sum)

