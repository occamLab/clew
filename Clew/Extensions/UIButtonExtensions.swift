//
//  UIButtonExtensions.swift
//  Clew
//
//  Created by Dieter Brehm on 6/10/19.
//  Copyright © 2019 OccamLab. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    /// Factory to make an image button.
    ///
    /// Used for start and stop recording and navigation buttons.
    ///
    /// - Parameters:
    ///   - containerView: button container, configured with `UIView.setupButtonContainer(withButton:)`
    ///   - buttonViewParts: holds information about the button (image, label, and target)
    /// - Returns: A formatted button
    ///
    /// - SeeAlso: `UIView.setupButtonContainer(withButton:)`
    ///
    /// - TODO:
    ///   - Implement AutoLayout
    static func makeImageButton(_ containerView: UIView, _ buttonViewParts: ActionButtonComponents) -> UIButton {
        let buttonWidth = containerView.bounds.size.width / 3.75
        
        let button = UIButton(type: .custom)
        button.tag = buttonViewParts.tag
        button.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonWidth)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        switch buttonViewParts.alignment {
        case .center:
            button.center.x = containerView.center.x
        case .right:
            button.center.x = containerView.center.x + UIScreen.main.bounds.size.width/3
        case .rightcenter:
            button.center.x = containerView.center.x + UIScreen.main.bounds.size.width/4.5
        case .left:
            button.center.x = containerView.center.x - UIScreen.main.bounds.size.width/3
        case .leftcenter:
            button.center.x = containerView.center.x - UIScreen.main.bounds.size.width/4.5
        }
        if containerView.mainText != nil {
            button.center.y = containerView.bounds.size.height * (8/10)
        } else {
            button.center.y = containerView.bounds.size.height * (6/10)
        }
        
        switch buttonViewParts.appearance {
        case .imageButton(let image):
            button.setImage(image, for: .normal)
        case .textButton(let label):
            button.setTitle(label, for: .normal)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.white.cgColor
        }
        
        button.accessibilityLabel = buttonViewParts.label
        button.addTarget(nil, action: buttonViewParts.targetSelector, for: .touchUpInside)
        
        return button
    }
}
