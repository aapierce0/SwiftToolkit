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
    
    static func overlayViewController() -> ViewControllerMenuItem {
        let menuItem = ViewControllerMenuItem()
        menuItem.title = "Overlay"
        menuItem.accessoryType = .disclosureIndicator
        
        let coordinator = OverlayViewCoordinator()
        menuItem.createViewController = {
            return coordinator.viewController()
        }
        return menuItem
    }
    
    static func formTableViewController() -> ViewControllerMenuItem {
        let menuItem = ViewControllerMenuItem()
        menuItem.title = "Form"
        menuItem.accessoryType = .disclosureIndicator
        
        menuItem.createViewController = {
            typealias Row = FormTableViewController.Row
            var row1 = Row(identifier: "FirstName")
            row1.label = "First Name"
            row1.placeholder = "Bugs"
            
            var row2 = Row(identifier: "LastName")
            row2.label = "Last Name"
            row2.placeholder = "Bunny"
            
            var row3 = Row(identifier: "EmailAddress")
            row3.placeholder = "carrot.eater@example.com"
            row3.keyboardType = .emailAddress
            
            var section1 = ItemSection<Row>(title: "Name", items: [row1, row2])
            section1.footer = "Enter your name so we know how to address you!"
            
            let section2 = ItemSection<Row>(title: "Contact", items: [row3])
            
            let viewController = FormTableViewController(style: .grouped)
            viewController.sections = [section1, section2]
            return viewController
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
        let cells: [MenuItem] = [
            ViewControllerMenuItem.pipViewController(),
            ViewControllerMenuItem.overlayViewController(),
            ViewControllerMenuItem.formTableViewController(),
        ]
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

