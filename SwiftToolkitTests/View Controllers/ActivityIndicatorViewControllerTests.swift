//
//  ActivityIndicatorViewControllerTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class ActivityIndicatorViewControllerTests: XCTestCase {
    
    var viewController: ActivityIndicatorViewController!

    override func setUp() {
        viewController = ActivityIndicatorViewController()
    }

    override func tearDown() {
        viewController = nil
    }

    func testActivityIndicatorViewIsPresent() {
        let subviews = viewController.view.subviews
        XCTAssert(subviews[0] is UIActivityIndicatorView)
    }
    
    func testActivityIndicatoryViewIsCentered() {
        loadView()
        let spinner = viewController.activityIndicatorView
        
        setViewSize(CGSize(width: 100, height: 100))
        XCTAssertEqual(spinner!.center, CGPoint(x: 50, y: 50))
        
        setViewSize(CGSize(width: 50, height: 200))
        XCTAssertEqual(spinner!.center, CGPoint(x: 25, y: 100))
    }
    
    func testActivityIndicatorIsAnimatingByDefault() {
        loadView()
        XCTAssertTrue(viewController.activityIndicatorView.isAnimating)
    }
    
    func testSetIsAnimatingPropertyToFalseBeforeLoading() {
        viewController.isAnimating = false
        loadView()
        XCTAssertFalse(viewController.activityIndicatorView.isAnimating)
    }
    
    func testSetIsAnimatingPropertyToFalseAfterLoading() {
        loadView()
        viewController.isAnimating = false
        XCTAssertFalse(viewController.activityIndicatorView.isAnimating)
    }
    
    func testSetIsAnimatingPropertyToTrueAfterSettingItToFalse() {
        viewController.isAnimating = false
        loadView()
        viewController.isAnimating = true
        XCTAssertTrue(viewController.activityIndicatorView.isAnimating)
    }

    func setViewSize(_ size: CGSize) {
        viewController.view.frame.size = size
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
    }
    
    @discardableResult func loadView() -> UIView {
        return viewController.view
    }

}
