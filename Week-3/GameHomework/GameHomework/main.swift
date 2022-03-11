//
//  main.swift
//  GameHomework
//
//  Created by Burak Ozay on 28.01.2022.
//

import Foundation

print("Enter your Nickname!")
 var nickName = readLine(strippingNewline: true)
print("Nickname: \(nickName ?? "Nickname")")

var score = 0
var g = 10.00
var quit: Bool = true

while quit {
    
    var bottleLocation: Double = 0.0
    var throwingAngle: Double = 0.0
    var throwingSpeed: Double = 0.0
    var bottleWidth: Double = 0.0
    
    while true {
        
        print("Enter bottle location!")
        bottleLocation = Double(readLine(strippingNewline: true)!)!
        if bottleLocation <= 0 || bottleLocation >= 1500 {
            print("Please enter a value between 0-1500 !")
            continue
        } else {
            print("Bottle location: \(bottleLocation)")
            break
        }
    
    }
    
    while true {
        
        print("Enter throwing angle!")
        throwingAngle = Double(readLine(strippingNewline: true)!)!
        if throwingAngle <= 0 || throwingAngle >= 90 {
            print("Please enter a value between 0-90 !")
            continue
        } else {
            print("Throwing angle: \(throwingAngle)")
            break
        }
    
    }
    
    while true {
        
        print("Enter throwing speed!")
        throwingSpeed = Double(readLine(strippingNewline: true)!)!
        if throwingSpeed <= 0 || throwingSpeed >= 100 {
            print("Please enter a value between 0-100 !")
            continue
        } else {
            print("Throwing speed: \(throwingSpeed)")
            break
        }
    
    }
    while true {
        
        print("Enter bottle size!")
        bottleWidth = Double(readLine(strippingNewline: true)!)!
        if bottleWidth <= 0.1 || bottleWidth >= 1 {
            print("Please enter a value between 0.1 - 1 !")
            continue
        } else {
            print("bottle size: \(bottleWidth )")
            break
        }
    
    }
    
    let calculatedRange = rangeCalculator(throwingSpeed: throwingSpeed, throwingAngle: throwingAngle)
    let resultBool = isHit(range: calculatedRange, bottleLocation: bottleLocation, bottleWidth: bottleWidth)
    resultWriter(p: resultBool)
    print("Score: \(score)")
    
    print("If you want to continue press 1 - If you want to quit press 0")
    
    var again : Bool = true
    while again {
        again = false
        let optionResult = readLine(strippingNewline: true)
        if optionResult == "0" {
            quit = false
            print("You stopped the game. Your final score is: \(score)")
            break
        } else if optionResult == "1" {
            continue
        } else {
            print("Please enter 1 or 0!")
            again = true
        }
    }
    
}

func rangeCalculator(throwingSpeed: Double, throwingAngle: Double) -> Double {
    let range = (throwingSpeed * throwingSpeed * (sin(2 * throwingAngle))) / g
    
    return range
}

func isHit(range: Double, bottleLocation: Double, bottleWidth: Double) -> Bool {
    if bottleLocation - bottleWidth <= range && range <= bottleLocation + bottleWidth {
        score += 1
        return true
    } else {
        return false
    }
}

func resultWriter(p: Bool) -> Void {
    if p {
        print("CONGRATS! YOU HIT THE BOTTLE!")
    } else {
        print("OOPS! TRY AGAIN!")
    }
}



