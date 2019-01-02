//
//  OverlayViewControllerTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 1/2/19.
//  Copyright © 2019 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class OverlayViewControllerTests: XCTestCase {
    
    var viewController : OverlayViewController!

    override func setUp() {
        viewController = OverlayViewController()
    }

    override func tearDown() {
        viewController = nil
    }

    func testBackgroundViewIsLoaded() {
        loadView()
        
        let backgroundView = viewController.backgroundContainerViewController.viewIfLoaded
        XCTAssert(backgroundView?.superview === viewController.view)
    }
    
    func testBackgroundViewResizes() {
        loadView()
        
        let backgroundView = viewController.backgroundContainerViewController.view!
        resizeView(CGSize(width: 100.0, height: 100.0))
        XCTAssertEqual(backgroundView.bounds.size, CGSize(width: 100.0, height: 100.0))
        
        resizeView(CGSize(width: 120.0, height: 80.0))
        XCTAssertEqual(backgroundView.bounds.size, CGSize(width: 120.0, height: 80.0))
    }
    
    func testOverlayViewIsLoaded() {
        loadView()
        
        let overlayView = viewController.overlayContainerViewController.viewIfLoaded
        XCTAssert(overlayView?.superview === viewController.view)
    }
    
    func testOverlayContentViewRespondsToParentSizeChange() {
        
        resizeView(CGSize(width: 100.0, height: 100.0))
        
        let mockViewController = MockViewController()
        viewController.overlayContainerViewController.setContent(mockViewController)
        mockViewController.constrainHeight(to: 40)
        viewController.view.layoutIfNeeded()
        
        let overlayView = viewController.overlayContainerViewController.view!
        XCTAssertEqual(overlayView.bounds.size, CGSize(width: 100.0, height: 40.0))
        
        resizeView(CGSize(width: 120.0, height: 80.0))
        XCTAssertEqual(overlayView.bounds.size, CGSize(width: 120.0, height: 40.0))
    }
    
    func testOverlayContentViewAdaptsToContentConstraints() {
        resizeView(CGSize(width: 100.0, height: 100.0))
        let overlayView = viewController.overlayContainerViewController.view!
        
        let shortViewController = MockViewController()
        shortViewController.constrainHeight(to: 40)
        viewController.overlayContainerViewController.setContent(shortViewController)
        XCTAssertEqual(overlayView.bounds.size, CGSize(width: 100.0, height: 40.0))
        
        let tallViewController = MockViewController()
        tallViewController.constrainHeight(to: 80)
        viewController.overlayContainerViewController.setContent(tallViewController)
        XCTAssertEqual(overlayView.bounds.size, CGSize(width: 100.0, height: 80.0))
    }
    
    func testBackgroundViewSetsSafeAreaInsets() {
        resizeView(CGSize(width: 100.0, height: 100.0))
        
        let shortViewController = MockViewController()
        shortViewController.constrainHeight(to: 40)
        viewController.overlayContainerViewController.setContent(shortViewController)
        viewController.view.layoutIfNeeded()
        
        XCTAssertEqual(viewController.backgroundContainerViewController.additionalSafeAreaInsets, UIEdgeInsets(top: 0, left: 0, bottom: 40.0, right: 0))
    }
    
    func loadView() {
        let _  = viewController.view
    }
    
    func resizeView(_ size: CGSize) {
        viewController.view.frame.size = size
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
    }

}
