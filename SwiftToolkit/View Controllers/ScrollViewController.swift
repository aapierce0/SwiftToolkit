//
//  ScrollViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

public class ScrollViewController: UIViewController {
    
    public weak var scrollView: UIScrollView!
    
    private(set) public var contentViewController: UIViewController!
    
    public var constrainsContentToFitWidth: Bool = false { didSet { activateLayoutConstraintsForContentViewIfLoaded() } }
    private var contentFitsWidthConstraint: NSLayoutConstraint!
    
    public var constrainsContentToFitHeight: Bool = false { didSet {
        activateLayoutConstraintsForContentViewIfLoaded() } }
    private var contentFitsHeightConstraint: NSLayoutConstraint!
    
    public convenience init(wrapping viewController: UIViewController) {
        self.init()
        setContent(viewController)
    }
    
    override public func loadView() {
        view = UIView()
        view.backgroundColor = .clear
        view.accessibilityIdentifier = "Scroll View Controller Wrapper View"
        
        loadScrollView()
    }
    
    private func loadScrollView() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        self.scrollView = scrollView
        
        activateLayoutConstraintsForScrollView()
    }
    
    private func activateLayoutConstraintsForScrollView() {
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.translatesAutoresizingMaskIntoConstraints = true
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setContentViewControllerInScrollView()
    }
    
    public func setContent(_ viewController: UIViewController) {
        if isViewLoaded {
            fatalError("Attempted to set the content view controller after view was loaded")
        } else {
            contentViewController = viewController
        }
    }
    
    private func setContentViewControllerInScrollView() {
        guard let viewController = contentViewController else { return }
        
        addChild(viewController)
        scrollView.addSubview(viewController.view)
        activateLayoutConstraintsForContentView()
        viewController.didMove(toParent: self)
    }
    
    private func activateLayoutConstraintsForContentViewIfLoaded() {
        if isContentViewLoaded {
            activateLayoutConstraintsForContentView()
        }
    }
    
    private var isContentViewLoaded: Bool {
        guard isViewLoaded else { return false }
        guard let contentViewController = contentViewController else { return false }
        return contentViewController.isViewLoaded
    }
    
    internal func activateLayoutConstraintsForContentView() {
        let contentView = contentViewController.view!
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        activateWidthConstraintForContentViewIfNeeded()
        activateHeightConstraintForContentViewIfNeeded()
        contentView.setNeedsLayout()
    }
    
    private func activateWidthConstraintForContentViewIfNeeded() {
        let widthConstraintIsActive = constrainsContentToFitWidth
        
        if contentFitsWidthConstraint == nil {
            contentFitsWidthConstraint = contentViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor)
        }
        
        contentFitsWidthConstraint.isActive = widthConstraintIsActive
    }
    
    private func activateHeightConstraintForContentViewIfNeeded() {
        let heightConstraintIsActive = constrainsContentToFitHeight
        
        if contentFitsHeightConstraint == nil {
            contentFitsHeightConstraint = contentViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor)
        }
        
        contentFitsHeightConstraint.isActive = heightConstraintIsActive
    }

}
