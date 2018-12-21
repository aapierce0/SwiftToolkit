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
        setupPIPViewController()
        
        setPIPOverlayShadowFromShadowEditor()
    }
    
    private func setupAccessoryViewController() {
        accessoryViewController = UIViewController()
        accessoryViewController.view.backgroundColor = UIColor(hue: 0.8, saturation: 0.5, brightness: 1.0, alpha: 1.0)
    }
    
    private func setupShadowEditorViewController() {
        shadowEditorViewController = ShadowEditorViewController.instantiateFromDesignatedNib()
        shadowEditorViewController.shadowDescriptor = .floatyDropShadow
        
        NotificationCenter.default.addObserver(self, selector: #selector(PictureInPictureViewCoordinator.shadowViewControllerDidChange(_:)), name: ShadowEditorViewController.Notification.valueDidChange, object: shadowEditorViewController)
    }
    
    private func setupPIPViewController() {
        pipViewController = PictureInPictureViewController()
        
        let backgroundViewController = viewControllerForPIPBackground()
        pipViewController.backgroundContainerViewController.setContent(backgroundViewController)
        
        let accessoryViewController = viewControllerForPIP()
        pipViewController.pictureInPictureContainerViewController.setContent(accessoryViewController)
        
        configureAppearanceOfPIPViewController()
        configureNavigationItemOfPIPViewController()
    }
    
    private func viewControllerForPIPBackground() -> UIViewController {
        return createWrapperViewControllerContainingContent()
    }
    
    private func viewControllerForPIP() -> UIViewController {
        let accessoryWrapper = ContainerViewController()
        accessoryWrapper.setContent(accessoryViewController)
        accessoryWrapper.masksToBounds = true
        accessoryWrapper.cornerRadius = 8.0
        return accessoryWrapper
    }
    
    private func configureAppearanceOfPIPViewController() {
        pipViewController.pictureInPictureContainerViewController.backgroundColor = .white
        pipViewController.pictureInPictureContainerViewController.contentInset = .uniform(4.0)
        pipViewController.pictureInPictureContainerViewController.cornerRadius = 12.0
        pipViewController.pictureInPictureContainerViewController.layerDescriptor.border.color = UIColor(white: 0.7, alpha: 1.0).cgColor
        pipViewController.pictureInPictureContainerViewController.layerDescriptor.border.width = .hairline
    }
    
    private func configureNavigationItemOfPIPViewController() {
        pipViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(PictureInPictureViewCoordinator.toggleBarButtonItemTapped(_:)))
    }
    
    @objc private func toggleBarButtonItemTapped(_ sender: UIBarButtonItem) {
        toggleAppearanceOfPictureInPictureOverlay()
    }
    
    private func toggleAppearanceOfPictureInPictureOverlay() {
        let isHidden = pipViewController.isPictureInPictureViewControllerHidden
        
        UIView.animate(withDuration: 0.3) {
            if isHidden {
                self.pipViewController.showPictureInPictureViewController()
                self.pipViewController.pictureInPictureContainerViewController.view.alpha = 1.0
            } else {
                self.pipViewController.hidePictureInPictureViewController()
                self.pipViewController.pictureInPictureContainerViewController.view.alpha = 0.0
            }
        }
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
        setPIPOverlayShadowFromShadowEditor()
    }
    
    private func setPIPOverlayShadowFromShadowEditor() {
        let shadow = shadowEditorViewController.shadowDescriptor
        pipViewController.pictureInPictureContainerViewController.layerDescriptor.shadow = shadow
    }
}
