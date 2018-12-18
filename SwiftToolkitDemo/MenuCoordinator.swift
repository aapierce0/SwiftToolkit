//
//  MenuCoordinator.swift
//  SwiftToolkitDemo
//
//  Created by Avery Pierce on 12/17/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation
import SwiftToolkit

class ViewControllerMenuItem : MenuItem {
    var title: String? = nil
    var accessoryType: UITableViewCell.AccessoryType? = nil
    var createViewController: () -> UIViewController = { return UIViewController() }
    
    static func pipViewController() -> ViewControllerMenuItem {
        let menuItem = ViewControllerMenuItem()
        menuItem.title = "Picture in Picture"
        menuItem.accessoryType = .disclosureIndicator
        
        let coordinator = PictureInPictureViewCoordinator()
        menuItem.createViewController = {
            return coordinator.viewController()
        }
        return menuItem
    }
}

class MenuCoordinator {
    
    private var navigationController: UINavigationController!
    private(set) var menuTableViewController: MenuTableViewController!
    
    func viewController() -> UIViewController {
        if navigationController == nil {
            setup()
        }
        
        return navigationController
    }
    
    func setup() {
        menuTableViewController = MenuTableViewController()
        menuTableViewController.delegate = self
        let cells: [MenuItem] = [ViewControllerMenuItem.pipViewController()]
        menuTableViewController.sections = [ItemSection(title: nil, items: cells)]
        
        navigationController = UINavigationController(rootViewController: menuTableViewController)
    }
    
    func displayViewController(for menuItem: MenuItem) {
        guard let viewControllerItem = menuItem as? ViewControllerMenuItem else { return }
        let viewController = viewControllerItem.createViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension MenuCoordinator : MenuTableViewControllerDelegate {
    func menuTableViewController(_ viewController: MenuTableViewController, didSelect item: MenuItem) {
        displayViewController(for: item)
    }
}

