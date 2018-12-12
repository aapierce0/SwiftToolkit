//
//  Sectionable.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/12/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation

/// indicates that this item can be put into sections automatically
public protocol Sectionable {
    var sectionTitle: String? { get }
}
