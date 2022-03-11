//
//  EulerHW.swift
//  Week-4
//
//  Created by Burak Ozay on 4.02.2022.
//

import Foundation

/*
 EULER 9-10
 */

//9

//func findProductForTriplet(sum: Int) -> Int? {
//
//    let range = Array(1..<sum/2).reverse()
//
//    for c in range {
//
//        for b in range {
//
//            for a in range {
//
//                guard a * a + b * b == c * c && a + b + c == sum else { continue }
//                return a * b * c
//
//            }
//
//        }
//
//    }
//
//    return nil
//
//}

//let tripletFor50 = findProductForTriplet(sum: 12) // 60
//let tripletFor1000 = findProductForTriplet(sum: 1000) // 31875000
//

//10

//
//func sumOfPrimes(max: Int) -> Int {
//
//    return max.primes().reduce(0, combine: +)
//
//}
//
//let sumOfPrimesFor10 = sumOfPrimes(max: 10) // 17
//let sumOfPrimesFor2000000 = sumOfPrimes(max: 2000000) // 142913828922
