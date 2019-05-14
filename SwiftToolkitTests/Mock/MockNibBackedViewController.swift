//
//  MockNibBackedViewController.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 1/25/19.
//  Copyright © 2019 Avery Pierce. All rights reserved.
//

import UIKit
import SwiftToolkit

extension MockNibBackedViewController : NibBackedViewController {
    static let nibName: String = "MockNibBackedViewController"
    static let nibBundle: Bundle? = Bundle(for: MockNibBackedViewController.self)
}

class MockNibBackedViewController: UIViewController {
    
    @IBOutlet weak var containerViewController: ContainerViewController?

}
