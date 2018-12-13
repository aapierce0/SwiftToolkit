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
        viewController.view.setNeedsLayout()
        viewController.didMove(toParent: self)
    }
    
}
