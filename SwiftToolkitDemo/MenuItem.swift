//
//  MenuItem.swift
//  SwiftToolkitDemo
//
//  Created by Avery Pierce on 12/17/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

protocol MenuItem {
    var title: String? { get }
    var accessoryType: UITableViewCell.AccessoryType? { get }
}
