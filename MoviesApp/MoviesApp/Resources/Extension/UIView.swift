//
//  UIView.swift
//  MoviesApp
//
//  Created by Burak Ozay on 26.04.2022.
//

import Foundation
import UIKit

@IBDesignable extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
              layer.cornerRadius = newValue
              layer.masksToBounds = (newValue > 0)
        }
    }
    
}
