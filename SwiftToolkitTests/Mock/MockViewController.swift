//
//  MockViewController.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

class MockViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "MockViewControllerView"
    }
    
    func constrain(to size: CGSize) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        view.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func constrainHeight(to height: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
