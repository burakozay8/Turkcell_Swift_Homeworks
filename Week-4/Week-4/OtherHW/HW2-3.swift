//
//  HW2-3.swift
//  Week-4
//
//  Created by Burak Ozay on 3.02.2022.
//

import Foundation

/*
 
 FRAME VS BOUNDS
 
 frame = a view's location and size using the parent view's coordinate system

 Important for: placing the view in the parent
 bounds = a view's location and size using its own coordinate system

 Important for: placing the view's content or subviews within itself
 
 */

//STATIC KEYWORD

class MyClass{
    static let typeProperty = "API_KEY"
    static var instancesOfMyClass = 0
    var price = 9.99
    let id = 5

}

//let obj = MyClass()
//obj.price // 9.99
//obj.id // 5

//

//MyClass.typeProperty // "API_KEY"
//MyClass.instancesOfMyClass // 0




