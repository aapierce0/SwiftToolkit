//
//  ContainerViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

public class ContainerViewController: UIViewController {
    
    struct ContentInset : Equatable {
        var top: CGFloat = 0
        var bottom: CGFloat = 0
        var left: CGFloat = 0
        var right: CGFloat = 0
        
        static let zero : ContentInset = ContentInset()
        
        static func uniform(_ inset: CGFloat) -> ContentInset {
            var contentInset = ContentInset()
            contentInset.top = inset
            contentInset.left = inset
            contentInset.right = inset
            contentInset.bottom = inset
            return contentInset
        }
    }
    
    private(set) public var contentViewController: UIViewController?

    var contentInset: ContentInset = .zero { didSet { configureLayoutConstraints() } }
    private var activeLayoutConstraints: [NSLayoutConstraint] = []
    
    var cornerRadius: CGFloat = 0 { didSet { configureCornerRadiusIfLoaded() } }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        addContentViewControllerToHierarchy()
        configureCornerRadiusIfLoaded()
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
        configureLayoutConstraints()
    }
    
    private func configureLayoutConstraints() {
        guard let contentView = contentViewController?.viewIfLoaded else { return }
        
        deactivateAllOwnedConstraints()
        activate(contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: contentInset.top))
        activate(contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: contentInset.left))
        activate(contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0 - contentInset.right))
        activate(contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0 - contentInset.bottom))
        contentView.setNeedsLayout()
    }
    
    private func activate(_ constraint: NSLayoutConstraint) {
        constraint.isActive = true
        activeLayoutConstraints.append(constraint)
    }
    
    private func deactivateAllOwnedConstraints() {
        while let constraint = activeLayoutConstraints.popLast() {
            constraint.isActive = false
        }
    }
    
    private func configureCornerRadiusIfLoaded() {
        viewIfLoaded?.layer.cornerRadius = cornerRadius
    }
    
}
