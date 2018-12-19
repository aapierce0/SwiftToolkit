//
//  PictureInPictureViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/17/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

public class PictureInPictureViewController: UIViewController {
    
    private let PIP_INSET : CGFloat = 8.0
    private let PIP_CORNER_RADIUS : CGFloat = 12.0
    private let PIP_HEIGHT : CGFloat = 120
    private let PIP_WIDTH : CGFloat = 80
    private let PIP_CONTENT_INSET : CGFloat = 4.0
    private var PIP_CONTENT_CORNER_RADIUS : CGFloat {
        return max(PIP_CORNER_RADIUS - PIP_CONTENT_INSET, 0)
    }
    
    
    private(set) public var primaryViewController: UIViewController!
    private let pictureInPictureWrapperContainerViewController = ContainerViewController()
    private let pictureInPictureContainerViewController = ContainerViewController()
    public var pictureInPictureViewController: UIViewController? {
        return pictureInPictureContainerViewController.contentViewController
    }
    
    
    public var pictureOverlayShadow: ShadowDescriptor = .documentDropShadow { didSet { configureWrapperShadowIfLoaded() } }
    
    convenience init(primaryViewController: UIViewController) {
        self.init()
        setPrimary(primaryViewController)
    }
    
    override public func loadView() {
        view = UIView()
        
        loadPrimaryViewController()
        loadPictureInPictureWrapperView()
        loadPictureInPictureContainerViewController()
    }
    
    private func loadPrimaryViewController() {
        guard let primaryViewController = primaryViewController else {
            fatalError("Attempted to load PictureInPictureViewController without primaryViewController")
        }
        
        addChild(primaryViewController)
        view.addSubview(primaryViewController.view)
        activateLayoutConstraintsForPrimaryViewController()
        primaryViewController.didMove(toParent: self)
    }
    
    private func activateLayoutConstraintsForPrimaryViewController() {
        guard let contentView = primaryViewController.view else { return }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func loadPictureInPictureWrapperView() {
        pictureInPictureWrapperContainerViewController.cornerRadius = PIP_CORNER_RADIUS
        pictureInPictureWrapperContainerViewController.view.backgroundColor = .white
        pictureInPictureWrapperContainerViewController.contentInset = .uniform(PIP_CONTENT_INSET)
        pictureInPictureWrapperContainerViewController.setContent(pictureInPictureContainerViewController)
        
        addChild(pictureInPictureWrapperContainerViewController)
        view.addSubview(pictureInPictureWrapperContainerViewController.view)
        pictureInPictureWrapperContainerViewController.didMove(toParent: self)
        
        configureWrapperShadowIfLoaded()
        activateLayoutConstraintsForPictureInPictureWrapperView()
    }
    
    private func configureWrapperShadowIfLoaded() {
        if let wrapperView = pictureInPictureWrapperContainerViewController.viewIfLoaded {
            wrapperView.layer.shadow = pictureOverlayShadow
        }
    }
    
    private func activateLayoutConstraintsForPictureInPictureWrapperView() {
        let pipView = pictureInPictureWrapperContainerViewController.view!
        
        pipView.translatesAutoresizingMaskIntoConstraints = false
        pipView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: PIP_INSET).isActive = true
        pipView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0 - PIP_INSET).isActive = true
        pipView.widthAnchor.constraint(equalToConstant: PIP_WIDTH).isActive = true
        pipView.heightAnchor.constraint(equalToConstant: PIP_HEIGHT).isActive = true
        pipView.setNeedsLayout()
    }
    
    private func loadPictureInPictureContainerViewController() {
        pictureInPictureContainerViewController.contentInset = .zero
        pictureInPictureContainerViewController.cornerRadius = PIP_CONTENT_CORNER_RADIUS
        
        pictureInPictureContainerViewController.view.layer.masksToBounds = true
    }

    
    
    public func setPrimary(_ viewController: UIViewController) {
        if isViewLoaded {
            fatalError("Attempted to set primaryViewController after it was already loaded")
        } else {
            primaryViewController = viewController
        }
    }
    
    public func setPictureInPicture(_ viewController: UIViewController) {
        pictureInPictureContainerViewController.setContent(viewController)
    }
}
