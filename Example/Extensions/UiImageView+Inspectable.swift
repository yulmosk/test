//
//  UiImageView+Inspectable.swift
//  Example
//
//  Created by Yulia Moskaleva on 17/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    @IBInspectable
    var cornerPictureRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
