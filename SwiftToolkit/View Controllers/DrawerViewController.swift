//
//  OverlayViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/21/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

open class DrawerViewController: UIViewController {

    private(set) public var backgroundContainerViewController = ContainerViewController()
    private(set) public var overlayPanelContainerViewController = ContainerViewController()
    
    private var scrollViewController : ScrollViewController!
    private var stackViewController : StackViewController!
    private var spacerViewController : ContainerViewController!
    
    open override func loadView() {
        view = UIView()
        
        setupBackgroundContainerViewController()
        setupOverlayViewController()
    }
    
    private func setupBackgroundContainerViewController() {
        addChild(backgroundContainerViewController)
        view.addSubview(backgroundContainerViewController.view)
        activateLayoutConstraintsForBackgroundView()
        backgroundContainerViewController.didMove(toParent: self)
    }
    
    private func activateLayoutConstraintsForBackgroundView() {
        let backgroundView = backgroundContainerViewController.view!
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.setNeedsLayout()
    }
    
    private func setupOverlayViewController() {
        setupSpacerViewController()
        setupStackViewController()
        setupScrollViewController()
        
        addChild(scrollViewController)
        view.addSubview(scrollViewController.view)
        activateLayoutConstraintsForScrollViewWrapper()
        scrollViewController.didMove(toParent: self)
    }
    
    private func setupSpacerViewController() {
        spacerViewController = ContainerViewController()
        spacerViewController.backgroundColor = .clear
    }
    
    private func setupStackViewController() {
        stackViewController = StackViewController()
        let _ = stackViewController.view
        stackViewController.stackView.axis = .vertical
        stackViewController.append(spacerViewController)
        stackViewController.append(overlayPanelContainerViewController)
    }
    
    private func setupScrollViewController() {
        scrollViewController = ScrollViewController()
        scrollViewController.contentContainerViewController.setContent(stackViewController)
        scrollViewController.constrainsContentToFitWidth = true
    }
    
    private func activateLayoutConstraintsForScrollViewWrapper() {
        let scrollWrapper = scrollViewController.view!
        scrollWrapper.translatesAutoresizingMaskIntoConstraints = false
        scrollWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollWrapper.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollWrapper.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollWrapper.setNeedsLayout()
        
        let contentView = scrollViewController.contentContainerViewController.view!
        contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor).isActive = true
        contentView.setNeedsLayout()
    }
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}
