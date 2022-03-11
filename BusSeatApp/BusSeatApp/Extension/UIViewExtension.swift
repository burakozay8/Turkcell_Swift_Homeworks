//
//  UIViewExtension.swift
//  BusSeatApp
//
//  Created by Burak Ozay on 14.02.2022.
//

import Foundation
import UIKit

extension UIView {
   @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}
