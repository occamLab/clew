//
//  AppleSignInController.swift
//  Clew
//
//  Created by Jasper Katzban on 3/31/21.
//  Copyright © 2021 OccamLab. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseAuth

/// A View Controller for signing user in with apple ID for logging purposes
@available(iOS 13.0, *)
class AppleSignInController: UIViewController {
    

    /// called when view appears (any time)
//    override func viewDidAppear(_ animated: Bool) {
//        /// TODO: set sign-in button as active voiceover component and configure other VO funcs
//        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.appleIdSignIn)
//        signInTitle.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
//        signInDescription.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
//        signInButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
////    }
    
    var authHelper: AuthenticationHelper?
    
    var signInTitle: UILabel!
    
    var signInDescription: UILabel!

    var signInButton: UIButton!
    
    /// called when the view has loaded.  We setup various app elements in here.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let waitingPeriod = ViewController.alignmentWaitingPeriod

        view = TransparentTouchView(frame:CGRect(x: 0,
                                           y: UIScreen.main.bounds.size.height*0.15,
                                           width: UIConstants.buttonFrameWidth * 1,
                                           height: UIScreen.main.bounds.size.height*0.75))
        
        view.backgroundColor = UIColor.white
        
    
        signInTitle = UILabel()
        let titleText = NSLocalizedString("signInWithAppleTitle", comment: "Title of the sign in window")
        signInTitle.textColor = UIColor.black
        signInTitle.textAlignment = .center
        signInTitle.numberOfLines = 0
        signInTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        signInTitle.lineBreakMode = .byWordWrapping
        signInTitle.font = UIFont.preferredFont(forTextStyle: .title1)
        signInTitle.text = titleText
        signInTitle.tag = UIView.mainTextTag
        signInTitle.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width / 1.1).isActive = true
                
        
        signInDescription = UILabel()

        var mainText:String

        mainText = String.localizedStringWithFormat(NSLocalizedString("signInWithAppleDescription", comment: "A description of why we'd like the user to sign in with their Apple ID"), waitingPeriod)
        
        signInDescription.textColor = UIColor.black
        signInDescription.textAlignment = .center
        signInDescription.numberOfLines = 0
        signInDescription.lineBreakMode = .byWordWrapping
        signInDescription.font = UIFont.preferredFont(forTextStyle: .body)
        signInDescription.text = mainText
        signInDescription.tag = UIView.mainTextTag
        
        
        signInButton = UIButton(type: .custom)
        signInButton.layer.cornerRadius = 0.5 * signInButton.bounds.size.width
        signInButton.clipsToBounds = true
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width / 1.1).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 5).isActive = true
        signInButton.setBackgroundImage(UIImage(named: "WhiteButtonBackground"), for: .normal)
        signInButton.imageView?.contentMode = .scaleAspectFit
        signInButton.setTitle(NSLocalizedString("signInWithAppleButtonText", comment: "This is the text which appears on the sign in with Apple buttton"),for: .normal)
        signInButton.setTitleColor(.black, for: .normal)
        signInButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 35)!
//        signInButton.accessibilityLabel = NSLocalizedString("signInwithAppleButtonAccessibilityLabel", comment: "A button that allows the user to sign into Clew with their Apple ID.")
        signInButton.titleLabel?.textAlignment = .center
        signInButton.titleLabel?.numberOfLines = 0
        signInButton.titleLabel?.lineBreakMode = .byWordWrapping
        signInButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        signInButton.titleEdgeInsets.top = 0
        signInButton.titleEdgeInsets.left = 5
        signInButton.titleEdgeInsets.bottom = 0
        signInButton.titleEdgeInsets.right = 5
        
    
        /// create stack view for aligning and distributing bottom layer buttons
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        /// define horizonal, centered, and equal alignment of elements
        /// inside the bottom stack
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        
        /// add elements to the stack
        stackView.addArrangedSubview(signInTitle)
        stackView.addArrangedSubview(signInDescription)
        stackView.addArrangedSubview(signInButton)

        /// size the stack
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        /// add target action for sign in button
        signInButton.addTarget(parent,
                                       action: #selector(signInWithApple),
                                      for: .touchUpInside)
    }
        
    @objc private func signInWithApple() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        /// handle sign in flow using FirbaseAuthentication Apple ID
        authHelper = AuthenticationHelper(window: appDelegate.window! )
        authHelper?.startSignInWithAppleFlow()
        
    }
}
