//
//  StackViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {
    
    private(set) weak var stackView: UIStackView!
    
    private(set) var arrangedViewControllers: [UIViewController] = []
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear
        
        loadStackView()
    }
    
    private func loadStackView() {
        let stackView = UIStackView()
        view.addSubview(stackView)
        self.stackView = stackView
        
        activateStackViewLayoutConstraints()
    }
    
    private func activateStackViewLayoutConstraints() {
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.translatesAutoresizingMaskIntoConstraints = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addAllArrangedViewControllersToStackView()
    }
    
    private func addAllArrangedViewControllersToStackView() {
        arrangedViewControllers.forEach { (viewController) in
            append(viewController)
        }
    }
    
    
    
    func append(_ viewController: UIViewController) {
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
    
    
    
    func insert(_ viewController: UIViewController, at index: Int) {
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

    
    
    func removeViewController(at index: Int) {
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
