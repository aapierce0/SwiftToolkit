//
//  ContainerViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

public class ContainerViewController: UIViewController {
    
    private(set) public var contentViewController: UIViewController?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        addContentViewControllerToHierarchy()
    }
    
    public func setContent(_ viewController: UIViewController) {
        contentViewController?.viewIfLoaded?.removeFromSuperview()
        contentViewController?.removeFromParent()
        
        contentViewController = viewController
        addContentviewControllerToHierarchyIfLoaded()
    }
    
    private func addContentviewControllerToHierarchyIfLoaded() {
        if isViewLoaded {
            addContentViewControllerToHierarchy()
        }
    }
    
    private func addContentViewControllerToHierarchy() {
        guard let viewController = contentViewController else { return }
        
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        activateLayoutConstraintsForContentViewController()
        viewController.view.setNeedsLayout()
        viewController.didMove(toParent: self)
    }
    
    private func activateLayoutConstraintsForContentViewController() {
        guard let contentView = contentViewController?.viewIfLoaded else { return }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.setNeedsLayout()
    }
    
}
