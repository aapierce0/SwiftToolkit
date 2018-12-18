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
    private let pictureInPictureContainerViewController = ContainerViewController()
    public var pictureInPictureViewController: UIViewController? {
        return pictureInPictureContainerViewController.contentViewController
    }
    
    private weak var pictureInPictureWrapperView: UIView!
    
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
        let wrapperView = UIView()
        wrapperView.backgroundColor = .white
        wrapperView.layer.cornerRadius = PIP_CORNER_RADIUS
        wrapperView.layer.shadowColor = UIColor.black.cgColor
        wrapperView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        wrapperView.layer.shadowRadius = 12.0
        wrapperView.layer.shadowOpacity = 0.3
        
        view.addSubview(wrapperView)
        pictureInPictureWrapperView = wrapperView
        activateLayoutConstraintsForPictureInPictureWrapperView()
    }
    
    private func activateLayoutConstraintsForPictureInPictureWrapperView() {
        let pipView = pictureInPictureWrapperView!
        
        pipView.translatesAutoresizingMaskIntoConstraints = false
        pipView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: PIP_INSET).isActive = true
        pipView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0 - PIP_INSET).isActive = true
        pipView.widthAnchor.constraint(equalToConstant: PIP_WIDTH).isActive = true
        pipView.heightAnchor.constraint(equalToConstant: PIP_HEIGHT).isActive = true
    }
    
    private func loadPictureInPictureContainerViewController() {
        pictureInPictureWrapperView.addSubview(pictureInPictureContainerViewController.view)
        activateLayoutConstraintsForPictureInPictureView()
        
        pictureInPictureContainerViewController.view.layer.cornerRadius = PIP_CONTENT_CORNER_RADIUS
        pictureInPictureContainerViewController.view.layer.masksToBounds = true
    }
    
    private func activateLayoutConstraintsForPictureInPictureView() {
        let wrapperView = pictureInPictureWrapperView!
        let containerView = pictureInPictureContainerViewController.view!
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: PIP_CONTENT_INSET).isActive = true
        containerView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: PIP_CONTENT_INSET).isActive = true
        containerView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: 0 - PIP_CONTENT_INSET).isActive = true
        containerView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 0 - PIP_CONTENT_INSET).isActive = true
        containerView.setNeedsLayout()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
