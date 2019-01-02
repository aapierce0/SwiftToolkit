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
        
        var shadow = ShadowDescriptor.floatyDropShadow
        shadow.opacity = 1.0
        rootViewController.overlayContainerViewController.layerDescriptor.shadow = shadow
    }
    
    private func createBackgroundViewController() -> UIViewController {
        let greenPlaidImage = UIImage(named: "GreenPlaidTile")!
        let greenPlaidColor = UIColor(patternImage: greenPlaidImage)
        let backgroundVC = createColoredViewController(greenPlaidColor)
        
        addFloatingLabel(to: backgroundVC.view)
        return backgroundVC
    }
    
    private func addFloatingLabel(to view: UIView) {
        let label = UILabel(frame: .zero)
        label.text = "Safe Area Bottom"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21.0)
        label.backgroundColor = .blue
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    private func createOverlayViewController() -> UIViewController {
        return OverlayDemoDrawerViewController.instantiateFromDesignatedNib()
    }
    
    private func createColoredViewController(_ color: UIColor) -> ContainerViewController {
        let viewController = ContainerViewController()
        viewController.backgroundColor = color
        return viewController
    }
}
