//
//  OverlayViewControllerTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/21/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class OverlayViewControllerTests: XCTestCase {
    
    var viewController: OverlayViewController!
    
    override func setUp() {
        viewController = OverlayViewController()
    }
    
    override func tearDown() {
        viewController = nil
    }
    
    func testBackgroundViewControllerIsAddedToViewHierarchy() {
        loadView()
        
        let rootView = viewController.view!
        let backgroundView = viewController.backgroundContainerViewController.view!
        XCTAssert(backgroundView.descends(from: rootView))
    }
    
    func testOverlayViewControllerIsAddedToViewHierarchy() {
        loadView()
        
        let rootView = viewController.view!
        let overlayView = viewController.overlayPanelContainerViewController.view!
        XCTAssert(overlayView.descends(from: rootView))
    }
    
    func loadView() {
        let _ = viewController.view
    }
}

fileprivate extension UIView {
    func descends(from ancestorView: UIView) -> Bool {
        guard let superview = self.superview else { return false }
        if superview === ancestorView {
            return true
        } else {
            return superview.descends(from: ancestorView)
        }
    }
}
