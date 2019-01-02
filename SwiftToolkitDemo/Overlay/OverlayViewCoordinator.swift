//
//  OverlayViewCoordinator.swift
//  SwiftToolkitDemo
//
//  Created by Avery Pierce on 1/2/19.
//  Copyright © 2019 Avery Pierce. All rights reserved.
//

import UIKit
import SwiftToolkit

class OverlayViewCoordinator {
    var rootViewController: OverlayViewController!
    
    func viewController() -> UIViewController {
        setupIfNeeded()
        return rootViewController
    }
    
    private func setupIfNeeded() {
        if rootViewController == nil {
            setup()
        }
    }
    
    private func setup() {
        rootViewController = OverlayViewController()
        
        let backgroundVC = createBackgroundViewController()
        let overlayVC = createOverlayViewController()
        
        rootViewController.backgroundContainerViewController.setContent(backgroundVC)
        rootViewController.overlayContainerViewController.setContent(overlayVC)
    }
    
    private func createBackgroundViewController() -> UIViewController {
        return createColoredViewController(.green)
    }
    
    private func createOverlayViewController() -> UIViewController {
        let viewController = createColoredViewController(.cyan)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        return viewController
    }
    
    private func createColoredViewController(_ color: UIColor) -> ContainerViewController {
        let viewController = ContainerViewController()
        viewController.backgroundColor = color
        return viewController
    }
}
