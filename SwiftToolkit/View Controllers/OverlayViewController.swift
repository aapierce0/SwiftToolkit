//
//  OverlayViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 1/2/19.
//  Copyright © 2019 Avery Pierce. All rights reserved.
//

import UIKit

public class OverlayViewController: UIViewController {
    
    private(set) public var backgroundContainerViewController = ContainerViewController()
    private(set) public var overlayContainerViewController = ContainerViewController()
    
    public override func loadView() {
        view = UIView()
        setup()
    }
    
    private func setup() {
        setupBackgroundContainerViewController()
        setupOverlayContainerViewController()
    }
    
    private func setupBackgroundContainerViewController() {
        addChild(backgroundContainerViewController)
        view.addSubview(backgroundContainerViewController.view)
        activateLayoutConstraintsForBackgroundContainerView()
        backgroundContainerViewController.didMove(toParent: self)
    }
    
    private func activateLayoutConstraintsForBackgroundContainerView() {
        let backgroundView = backgroundContainerViewController.view!
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.setNeedsLayout()
    }
    
    private func setupOverlayContainerViewController() {
        addChild(overlayContainerViewController)
        view.addSubview(overlayContainerViewController.view)
        activateLayoutConstraintsForOverlayView()
        overlayContainerViewController.didMove(toParent: self)
    }
    
    private func activateLayoutConstraintsForOverlayView() {
        let overlayView = overlayContainerViewController.view!
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor).isActive = true
        overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        overlayView.setNeedsLayout()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let overlayHeight = overlayContainerViewController.view.bounds.height
        backgroundContainerViewController.additionalSafeAreaInsets.bottom = overlayHeight
    }
}
