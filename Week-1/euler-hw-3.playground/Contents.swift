import Cocoa

var n = 600851475143
var quo = 2

while quo <= n {
    
    if n % quo == 0 {
        n /= quo
    } else {
        quo += 1
    }
    
}
print(quo)
