//
//  PopupButton.swift
//  Example
//
//  Created by Yulia Moskaleva on 17/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import UIKit

extension UIButton {
    class func popupButton(with title: String? = nil, fontSize: CGFloat = 14) -> UIButton {
        let button = UIButton(type: .system)
        
        button.backgroundColor = UIColor.primary()
        
        button.contentEdgeInsets = UIEdgeInsets(
            top: 15, left: 15, bottom: 15, right: 15
        )
        
        if let label = button.titleLabel {
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.font = UIFont.boldSystemFont(ofSize: fontSize)
        }
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }
}


