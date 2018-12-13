//
//  NibBackedViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

public protocol NibBackedViewController {
    static var nibName: String { get }
    static var nibBundle: Bundle? { get }
}

public extension NibBackedViewController {
    static func designatedNib() -> UINib {
        return UINib(nibName: nibName, bundle: nibBundle)
    }
}

public extension NibBackedViewController where Self : UIViewController {
    static func instantiateFromDesignatedNib() -> Self {
        return Self(nibName: nibName, bundle: nibBundle)
    }
}
