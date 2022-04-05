//
//  Collection.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 3.04.2022.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
