import Cocoa

// Soru 1

func isPalindrome(myString:String, myNumber: Int) -> Bool {
    
    let numberString = String(myNumber)
    
    let reverseNumberString = String(numberString.reversed())
    let reverseString = String(myString.reversed())
    
    if(myString != "" && myString == reverseString || numberString != "" && numberString == reverseNumberString) {
        return true
    } else {
        return false
    }
}

print(isPalindrome("ey edip adanada pide ye"))
print(isPalindrome(909))

//Soru 2

func isPrime(_ n: Int) -> Bool {
    guard n >= 2     else { return false }
    guard n != 2     else { return true  }
    guard n % 2 != 0 else { return false }
    return !stride(from: 3, through: Int(sqrt(Double(n))), by: 2).contains { n % $0 == 0 }
}


// if let- guard let farkı

// use if let if you just want to unwrap some optionals, but prefer guard let if you’re specifically checking that conditions are correct before continuing.


// Soru 4
// Soru 5


//Project-euler Q6

func run() -> Int {

        var sumOfSquares = 0
        var sum = 0

        let end = 100

        for i in 1...end {
            sumOfSquares += i * i
            sum += i
        }

        let squareOfSum = sum * sum

        let diff = squareOfSum - sumOfSquares

        return diff
    }

// Project-euler Q5

func findSmallestMultiple() -> Int {
    
    let start = 11
    let end = 20
    
    var number = end
    var i = 0
    
    repeat {
        
        for j in start...end {
            if (number % j == 0) {
                i += 1
            } else {
                break;
            }
        }
        
        if (i != (end - start + 1)) {
            i = 0
            number += 1
        }
    } while(i != (end - start + 1))
    
    return number
}

//project-euler Q4

func findPalindromeNum() -> Int {
        
        let start = 100
        let end = 1000
        var auxStart = start
        
        var largest = 0
        
        for i in start..<end {
            for j in auxStart..<end {
                let result = i * j
                
                if isPalindrome(result) {
                    largest = result > largest ? result : largest
                }
            }
            
            auxStart += 1
        }
        
        return largest
    }
    
    func isPalindrome(_ number: Int) -> Bool {
        let string = String(number)
        
        return isPalindrome(string)
    }
    
    func isPalindrome(_ text: String) -> Bool {
        let chars: [Character] = text.reversed()
        
        let strings: [String] = chars.compactMap { (character: Character) -> String? in
            return String(character)
        }
        
        let reverse = strings.joined(separator: "")
        
        return reverse == text
    }











