//
//  FormTableViewCell.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 1/9/19.
//  Copyright © 2019 Avery Pierce. All rights reserved.
//

import UIKit

class FormTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    func configure(with row: FormTableViewController.Row) {
        textField.text = row.value
        textField.placeholder = row.placeholder
        textField.keyboardType = row.keyboardType
        
        if let label = row.label {
            showLabel(withText: label)
        } else {
            hideLabel()
        }
    }
    
    private func showLabel(withText text: String) {
        label.text = text
        label.isHidden = false
        textField.textAlignment = .right
    }
    
    private func hideLabel() {
        label.text = nil
        label.isHidden = true
        textField.textAlignment = .left
    }
    
}
