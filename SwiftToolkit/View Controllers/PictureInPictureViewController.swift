//
//  PictureInPictureViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/17/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

fileprivate let PIP_INSET : CGFloat = 8.0
fileprivate let PIP_HEIGHT : CGFloat = 120
fileprivate let PIP_WIDTH : CGFloat = 80

public class PictureInPictureViewController: UIViewController {
    
    private(set) public var backgroundContainerViewController = ContainerViewController()
    private(set) public var pictureInPictureContainerViewController = ContainerViewController()
    
    convenience init(background backgroundViewController: UIViewController? = nil, pictureInPicture pipViewController: UIViewController? = nil) {
        self.init()
        
        if let backgroundViewController = backgroundViewController {
            backgroundContainerViewController.setContent(backgroundViewController)
        }
        
        if let pipViewController = pipViewController {
            pictureInPictureContainerViewController.setContent(pipViewController)
        }
    }
    
    override public func loadView() {
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
}
