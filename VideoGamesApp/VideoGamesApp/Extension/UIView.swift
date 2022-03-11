//
//  UIView.swift
//  VideoGamesApp
//
//  Created by Burak Ozay on 6.03.2022.
//

import Foundation
import UIKit

//extension UIView {
//   @IBInspectable var cornerRadius: CGFloat {
//        get { return cornerRadius }
//        set {
//            self.layer.cornerRadius = newValue
//        }
//    }
//
//}

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
              layer.cornerRadius = newValue

              // If masksToBounds is true, subviews will be
              // clipped to the rounded corners.
              layer.masksToBounds = (newValue > 0)
        }
    }
}


