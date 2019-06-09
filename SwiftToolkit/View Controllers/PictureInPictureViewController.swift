//
//  PictureInPictureViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/17/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

fileprivate let PIP_INSET : CGFloat = 8.0

open class PictureInPictureViewController: UIViewController {
    
    private(set) public var backgroundContainerViewController = ContainerViewController()
    private(set) public var pictureInPictureContainerViewController = ContainerViewController()
    
    private var activePictureInPictureLayoutConstraints: [NSLayoutConstraint] = []
    private(set) public var isPictureInPictureViewControllerHidden : Bool = false { didSet { configurePIPViewLayoutIfLoaded() } }
    
    private var pipHeightLayoutConstraint: NSLayoutConstraint!
    private var pipWidthLayoutConstraint: NSLayoutConstraint!
    
    convenience init(background backgroundViewController: UIViewController? = nil, pictureInPicture pipViewController: UIViewController? = nil) {
        self.init()
        
        if let backgroundViewController = backgroundViewController {
            backgroundContainerViewController.setContent(backgroundViewController)
        }
        
        if let pipViewController = pipViewController {
            pictureInPictureContainerViewController.setContent(pipViewController)
        }
    }
    
    
    
    
    // MARK: - Construction
    
    open override func loadView() {
        view = UIView()
        
        loadBackgroundContainerViewController()
        loadPictureInPictureContainerViewController()
    }
    
    private func loadBackgroundContainerViewController() {
        addChild(backgroundContainerViewController)
        view.addSubview(backgroundContainerViewController.view)
        activateLayoutConstraintsForPrimaryViewController()
        backgroundContainerViewController.didMove(toParent: self)
    }
    
    private func activateLayoutConstraintsForPrimaryViewController() {
        let contentView = backgroundContainerViewController.view!
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.setNeedsLayout()
    }
    
    private func loadPictureInPictureContainerViewController() {
        addChild(pictureInPictureContainerViewController)
        view.addSubview(pictureInPictureContainerViewController.view)
        createPictureInPictureContainerLayoutConstraints()
        configurePIPViewLayout()
        pictureInPictureContainerViewController.didMove(toParent: self)
    }
    
    private func createPictureInPictureContainerLayoutConstraints() {
        let pipView = pictureInPictureContainerViewController.view!
        let pipSize = pictureInPictureContainerViewController.preferredContentSize
        pipWidthLayoutConstraint = pipView.widthAnchor.constraint(equalToConstant: pipSize.width)
        pipWidthLayoutConstraint.priority = .defaultLow
        pipWidthLayoutConstraint.isActive = true
        pipHeightLayoutConstraint = pipView.heightAnchor.constraint(equalToConstant: pipSize.height)
        pipHeightLayoutConstraint.priority = .defaultLow
        pipHeightLayoutConstraint.isActive = true
    }
    
    private func configurePIPViewLayoutIfLoaded() {
        if isViewLoaded {
            configurePIPViewLayout()
        }
    }
    
    private func configurePIPViewLayout() {
        deactivateAllLayoutConstraintsForPictureInPictureView()
        if isPictureInPictureViewControllerHidden {
            activateLayoutConstraintsForPictureInPictureWrapperViewOffScreen()
        } else {
            activateLayoutConstraintsForPictureInPictureWrapperView()
        }
    }
    
    private func activateLayoutConstraintsForPictureInPictureWrapperView() {
        let pipView = pictureInPictureContainerViewController.view!
        
        func activate(_ layoutConstraint: NSLayoutConstraint) {
            activateLayoutConstraintForPictureInPictureView(layoutConstraint)
        }
        
        pipView.translatesAutoresizingMaskIntoConstraints = false
        activate(pipView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: PIP_INSET))
        activate(pipView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0 - PIP_INSET))
        pipView.setNeedsLayout()
    }
    
    private func activateLayoutConstraintsForPictureInPictureWrapperViewOffScreen() {
        let pipView = pictureInPictureContainerViewController.view!
        
        func activate(_ layoutConstraint: NSLayoutConstraint) {
            activateLayoutConstraintForPictureInPictureView(layoutConstraint)
        }
        
        pipView.translatesAutoresizingMaskIntoConstraints = false
        activate(pipView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: PIP_INSET))
        activate(pipView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: PIP_INSET))
        pipView.setNeedsLayout()
    }
    
    private func activateLayoutConstraintForPictureInPictureView(_ layoutConstraint: NSLayoutConstraint) {
        layoutConstraint.isActive = true
        activePictureInPictureLayoutConstraints.append(layoutConstraint)
    }
    
    private func deactivateAllLayoutConstraintsForPictureInPictureView() {
        while let layoutConstraint = activePictureInPictureLayoutConstraints.popLast() {
            layoutConstraint.isActive = false
            pictureInPictureContainerViewController.viewIfLoaded?.removeConstraint(layoutConstraint)
        }
    }
    
    // MARK: -
    
    public func hidePictureInPictureViewController() {
        isPictureInPictureViewControllerHidden = true
        viewIfLoaded?.layoutIfNeeded()
    }
    
    public func showPictureInPictureViewController() {
        isPictureInPictureViewControllerHidden = false
        viewIfLoaded?.layoutIfNeeded()
    }
    
    
    open override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        view.setNeedsUpdateConstraints()
        view.setNeedsLayout()
    }
    
    open override func updateViewConstraints() {
        super.updateViewConstraints()
        let pipSize = pictureInPictureContainerViewController.preferredContentSize
        pipHeightLayoutConstraint.constant = pipSize.height
        pipWidthLayoutConstraint.constant = pipSize.width
        view.setNeedsLayout()
    }
}
