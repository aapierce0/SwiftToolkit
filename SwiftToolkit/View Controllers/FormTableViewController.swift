//
//  FormTableViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 1/9/19.
//  Copyright © 2019 Avery Pierce. All rights reserved.
//

import UIKit

public class FormTableViewController: UITableViewController {
    public struct Row {
        
        public var identifier: String
        public var placeholder: String?
        public var value: String?
        public var label: String?
        public var keyboardType: UIKeyboardType = UIKeyboardType.default
        
        public init(identifier: String) {
            self.identifier = identifier
        }
    }
    
    private enum ReuseIdentifiers {
        static let formCell = "FormCell"
    }
    
    public var sections: [ItemSection<Row>] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        registerClassesForTableView()
    }
    
    private func registerClassesForTableView() {
        let nib = UINib(nibName: "FormTableViewCell", bundle: Bundle(for: FormTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: ReuseIdentifiers.formCell)
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    public override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = getRow(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.formCell, for: indexPath) as! FormTableViewCell
        cell.configure(with: row)
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? FormTableViewCell
        cell?.textField.becomeFirstResponder()
    }
    
    private func getRow(at indexPath: IndexPath) -> Row {
        return sections[indexPath.section].items[indexPath.row]
    }
}
