//
//  UICollectionViewCell.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
       return UINib(nibName: identifier, bundle: nil)
    }

}
