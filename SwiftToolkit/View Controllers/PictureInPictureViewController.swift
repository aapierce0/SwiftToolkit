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
    private let DEFAULT_PIP_SHADOW : ShadowDescriptor = .documentDropShadow
    
    
    private(set) public var backgroundContainerViewController = ContainerViewController()
    private(set) public var pictureInPictureContainerViewController = ContainerViewController()
    public var pictureInPictureViewController: UIViewController? {
        return pictureInPictureContainerViewController.contentViewController
    }
    
    convenience init(primaryViewController: UIViewController) {
        self.init()
        setPrimary(primaryViewController)
    }
    
    override public func loadView() {
        view = UIView()
        
        loadPrimaryViewController()
        loadPictureInPictureWrapperView()
    }
    
    private func loadPrimaryViewController() {
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
    
    private func loadPictureInPictureWrapperView() {
        addChild(pictureInPictureContainerViewController)
        view.addSubview(pictureInPictureContainerViewController.view)
        activateLayoutConstraintsForPictureInPictureWrapperView()
        pictureInPictureContainerViewController.didMove(toParent: self)
    }
    
    private func activateLayoutConstraintsForPictureInPictureWrapperView() {
        let pipView = pictureInPictureContainerViewController.view!
        
        pipView.translatesAutoresizingMaskIntoConstraints = false
        pipView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: PIP_INSET).isActive = true
        pipView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0 - PIP_INSET).isActive = true
        pipView.widthAnchor.constraint(equalToConstant: PIP_WIDTH).isActive = true
        pipView.heightAnchor.constraint(equalToConstant: PIP_HEIGHT).isActive = true
        pipView.setNeedsLayout()
    }

    
    
    public func setPrimary(_ viewController: UIViewController) {
        backgroundContainerViewController.setContent(viewController)
    }
    
    public func setPictureInPicture(_ viewController: UIViewController) {
        pictureInPictureContainerViewController.setContent(viewController)
    }
}
