//
//  ContainerViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

open class ContainerViewController: UIViewController {
    
    public struct ContentInset : Equatable {
        public var top: CGFloat = 0
        public var bottom: CGFloat = 0
        public var left: CGFloat = 0
        public var right: CGFloat = 0
        
        public static let zero : ContentInset = ContentInset()
        
        public static func uniform(_ inset: CGFloat) -> ContentInset {
            var contentInset = ContentInset()
            contentInset.top = inset
            contentInset.left = inset
            contentInset.right = inset
            contentInset.bottom = inset
            return contentInset
        }
    }
    
    private(set) public var contentViewController: UIViewController?

    public var contentInset: ContentInset = .zero { didSet { configureLayoutConstraints() } }
    private var activeLayoutConstraints: [NSLayoutConstraint] = []
    
    public var layerDescriptor : ViewLayerDescriptor = ViewLayerDescriptor() {
        didSet { configureViewLayerIfLoaded() }
    }
    
    public var backgroundColor : UIColor? = nil { didSet { configureBackgroundColorIfLoaded() } }
    public var alpha : CGFloat = 1.0 { didSet { configureAlphaIfLoaded() } }

    open override func viewDidLoad() {
        super.viewDidLoad()

        addContentViewControllerToHierarchy()
        configureViewLayerIfLoaded()
        configureBackgroundColorIfLoaded()
        configureAlphaIfLoaded()
    }
    
    public func setContent(_ viewController: UIViewController?) {
        removeCurrentViewControllerIfNeeded()
        contentViewController = viewController
        addContentviewControllerToHierarchyIfLoaded()
        viewIfLoaded?.layoutIfNeeded()
    }
    
    private func removeCurrentViewControllerIfNeeded() {
        contentViewController?.viewIfLoaded?.removeFromSuperview()
        contentViewController?.removeFromParent()
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
        activateLayoutConstraintsForContentViewController()
        preferredContentSize = viewController.preferredContentSize
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
    
    private func configureViewLayerIfLoaded() {
        viewIfLoaded?.layer.configure(with: layerDescriptor)
    }
    
    private func configureBackgroundColorIfLoaded() {
        viewIfLoaded?.backgroundColor = backgroundColor
    }
    
    private func configureAlphaIfLoaded() {
        viewIfLoaded?.alpha = alpha
    }
    
    open override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        preferredContentSize = container.preferredContentSize
    }
    
}

// MARK: convenience properties

public extension ContainerViewController {
    var cornerRadius: CGFloat {
        get { return layerDescriptor.cornerRadius }
        set { layerDescriptor.cornerRadius = newValue }
    }
    var masksToBounds: Bool {
        get { return layerDescriptor.masksToBounds }
        set { layerDescriptor.masksToBounds = newValue }
    }
}
