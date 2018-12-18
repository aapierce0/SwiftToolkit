//
//  PictureInPictureViewCoordinator.swift
//  SwiftToolkitDemo
//
//  Created by Avery Pierce on 12/18/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation
import SwiftToolkit

class PictureInPictureViewCoordinator {
    
    var pipViewController: PictureInPictureViewController!
    var accessoryViewController: UIViewController!
    var shadowEditorViewController: ShadowEditorViewController!
    
    func viewController() -> UIViewController {
        if pipViewController == nil {
            setup()
        }
        
        return pipViewController
    }
    
    private func setup() {
        
        setupAccessoryViewController()
        setupShadowEditorViewController()
        
        pipViewController = PictureInPictureViewController()
        let primary = createWrapperViewControllerContainingContent()
        pipViewController.setPrimary(primary)
        pipViewController.setPictureInPicture(accessoryViewController)
    }
    
    private func setupAccessoryViewController() {
        accessoryViewController = UIViewController()
        accessoryViewController.view.backgroundColor = UIColor(hue: 0.8, saturation: 0.5, brightness: 1.0, alpha: 1.0)
    }
    
    private func setupShadowEditorViewController() {
        shadowEditorViewController = ShadowEditorViewController.instantiateFromDesignatedNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(PictureInPictureViewCoordinator.shadowViewControllerDidChange(_:)), name: ShadowEditorViewController.Notification.valueDidChange, object: shadowEditorViewController)
    }
    
    private func createWrapperViewControllerContainingContent() -> StackViewController {
        let stackViewWrapper = StackViewController()
        let _ = stackViewWrapper.view
        stackViewWrapper.stackView.axis = .vertical
        stackViewWrapper.append(spacerViewController())
        stackViewWrapper.append(shadowEditorViewController)
        return stackViewWrapper
    }
    
    private func spacerViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        viewController.view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return viewController
    }
    
    @objc private func shadowViewControllerDidChange(_ notification: NSNotification) {
        let shadow = shadowEditorViewController.shadowDescriptor
        pipViewController.pictureOverlayShadow = shadow
    }
}
