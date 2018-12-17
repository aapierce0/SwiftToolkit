//
//  PictureInPictureViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/17/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

public class PictureInPictureViewController: UIViewController {
    
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
        wrapperView.layer.cornerRadius = 4.0
        view.addSubview(wrapperView)
        pictureInPictureWrapperView = wrapperView
        activateLayoutConstraintsForPictureInPictureWrapperView()
    }
    
    private func activateLayoutConstraintsForPictureInPictureWrapperView() {
        let pipView = pictureInPictureWrapperView!
        
        pipView.translatesAutoresizingMaskIntoConstraints = false
        pipView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
        pipView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true
        pipView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        pipView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func loadPictureInPictureContainerViewController() {
        pictureInPictureWrapperView.addSubview(pictureInPictureContainerViewController.view)
        activateLayoutConstraintsForPictureInPictureView()
    }
    
    private func activateLayoutConstraintsForPictureInPictureView() {
        let wrapperView = pictureInPictureWrapperView!
        let containerView = pictureInPictureContainerViewController.view!
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 4.0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 4.0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -4.0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -4.0).isActive = true
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
