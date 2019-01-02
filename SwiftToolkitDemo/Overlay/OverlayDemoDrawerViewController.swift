//
//  OverylayDemoDrawerViewController.swift
//  SwiftToolkitDemo
//
//  Created by Avery Pierce on 1/2/19.
//  Copyright © 2019 Avery Pierce. All rights reserved.
//

import UIKit
import SwiftToolkit

extension OverlayDemoDrawerViewController : NibBackedViewController {
    static let nibName: String = "OverlayDemoDrawerViewController"
    static let nibBundle: Bundle? = nil
}

class OverlayDemoDrawerViewController: UIViewController {
    
    var height : CGFloat = 300 { didSet { updateHeightConstraintIfAble() } }
    
    private var heightLayoutConstraint : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heightLayoutConstraint = view.heightAnchor.constraint(equalToConstant: self.height)
        heightLayoutConstraint.priority = .defaultHigh
        heightLayoutConstraint.isActive = true
    }
    
    private func updateHeightConstraintIfAble() {
        heightLayoutConstraint?.constant = height
        viewIfLoaded?.setNeedsLayout()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        toggleHeight()
    }
    
    func toggleHeight() {
        if self.height >= 300 {
            self.height = 100
        } else {
            self.height = 300
        }
        
        UIView.animate(withDuration: 0.4) {
            self.viewIfLoaded?.superview?.superview?.layoutIfNeeded()
        }
    }
}
