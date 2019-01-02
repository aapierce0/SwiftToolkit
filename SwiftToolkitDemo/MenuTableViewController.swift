//
//  MenuTableViewController.swift
//  SwiftToolkitDemo
//
//  Created by Avery Pierce on 12/17/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit
import SwiftToolkit

protocol MenuTableViewControllerDelegate : class {
    func menuTableViewController(_ viewController: MenuTableViewController, didSelect item: MenuItem)
}

class MenuTableViewController: UITableViewController {
    
    var sections: [ItemSection<MenuItem>] = [] { didSet { tableView.reloadData() } }

    weak var delegate: MenuTableViewControllerDelegate?

    convenience init() {
        self.init(style: .grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }
    
    func prepareTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = getItem(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.accessoryType ?? .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = getItem(at: indexPath)
        delegate?.menuTableViewController(self, didSelect: item)
    }
    
    private func getItem(at indexPath: IndexPath) -> MenuItem {
        return sections[indexPath.section].items[indexPath.row]
    }

}
