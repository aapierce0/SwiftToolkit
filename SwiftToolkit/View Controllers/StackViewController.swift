//
//  StackViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

public class StackViewController: UIViewController {
    
    private(set) public weak var stackView: UIStackView!
    
    private(set) public var arrangedViewControllers: [UIViewController] = []
    
    public var axis: NSLayoutConstraint.Axis = .vertical { didSet { configureStackViewAxisIfLoaded() } }
    
    override public func loadView() {
        view = UIView()
        view.backgroundColor = .clear
        
        loadStackView()
    }
    
    private func loadStackView() {
        let stackView = UIStackView()
        view.addSubview(stackView)
        self.stackView = stackView
        
        activateStackViewLayoutConstraintsExplicitly()
        configureStackViewAxisIfLoaded()
    }

    private func activateStackViewLayoutConstraintsExplicitly() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stackView.setNeedsLayout()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        addAllArrangedViewControllersToStackView()
    }
    
    private func configureStackViewAxisIfLoaded() {
        stackView?.axis = axis
    }
    
    private func addAllArrangedViewControllersToStackView() {
        arrangedViewControllers.forEach { (viewController) in
            append(viewController)
        }
    }
    
    
    
    public func append(_ viewController: UIViewController) {
        arrangedViewControllers.append(viewController)
        addViewControllerToStackViewIfLoaded(viewController)
    }
    
    private func addViewControllerToStackViewIfLoaded(_ viewController: UIViewController) {
        if isViewLoaded {
            addViewControllerToStackView(viewController)
        }
    }
    
    private func addViewControllerToStackView(_ viewController: UIViewController) {
        addChild(viewController)
        stackView.addArrangedSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    
    
    public func insert(_ viewController: UIViewController, at index: Int) {
        arrangedViewControllers.insert(viewController, at: index)
        insertViewControllerInStackViewIfLoaded(viewController, at: index)
    }
    
    private func insertViewControllerInStackViewIfLoaded(_ viewController: UIViewController, at index: Int) {
        if isViewLoaded {
            insertViewControllerInStackView(viewController, at: index)
        }
    }
    
    private func insertViewControllerInStackView(_ viewController: UIViewController, at index: Int) {
        addChild(viewController)
        stackView.insertArrangedSubview(viewController.view, at: index)
        viewController.didMove(toParent: self)
    }

    
    
    public func removeViewController(at index: Int) {
        let viewController = arrangedViewControllers[index]
        arrangedViewControllers.remove(at: index)
        
        removeViewControllerFromStackViewIfLoaded(viewController)
    }
    
    private func removeViewControllerFromStackViewIfLoaded(_ viewController: UIViewController) {
        if isViewLoaded {
            removeViewControllerFromStackView(viewController)
        }
    }
    
    private func removeViewControllerFromStackView(_ viewController: UIViewController) {
        if let view = viewController.viewIfLoaded {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        viewController.removeFromParent()
    }
}
