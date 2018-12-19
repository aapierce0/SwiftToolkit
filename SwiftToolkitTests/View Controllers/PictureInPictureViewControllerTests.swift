//
//  PictureInPictureViewControllerTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/17/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class PictureInPictureViewControllerTests: XCTestCase {
    
    var viewController: PictureInPictureViewController!

    override func setUp() {
        viewController = PictureInPictureViewController()
    }

    override func tearDown() {
        viewController = nil
    }

    func testInitWithPrimaryViewController() {
        let mockViewController = MockViewController()
        viewController = PictureInPictureViewController(primaryViewController: mockViewController)
        XCTAssert(viewController.backgroundContainerViewController.contentViewController === mockViewController)
    }
    
    func testViewLoadsWithPrimaryContent() {
        let mockViewController = MockViewController()
        viewController.setPrimary(mockViewController)
        loadView()
        XCTAssert(viewController.backgroundContainerViewController.contentViewController === mockViewController)
        XCTAssertTrue(mockViewController.isViewLoaded)
    }
    
    func testPrimaryContentResizes() {
        let mockViewController = MockViewController()
        viewController.setPrimary(mockViewController)
        loadView()
        
        resizeView(CGSize(width: 100, height: 100))
        viewController.view.layoutIfNeeded()
        XCTAssertEqual(mockViewController.view.frame, CGRect(x: 0, y: 0, width: 100, height: 100))
        
        resizeView(CGSize(width: 200, height: 200))
        viewController.view.layoutIfNeeded()
        XCTAssertEqual(mockViewController.view.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    func testPictureInPictureAppears() {
        let primaryViewController = MockViewController()
        viewController.setPrimary(primaryViewController)
        let pipViewController = MockViewController()
        viewController.setPictureInPicture(pipViewController)
        loadView()
        resizeView(CGSize(width: 400, height: 800))
        viewController.view.layoutIfNeeded()
        
        XCTAssertEqual(viewController.view.subviews.count, 2)
        let wrapperView = viewController.view.subviews[1]
        XCTAssertEqual(wrapperView.frame, CGRect(x: 312, y: 8, width: 80, height: 120))
        
        let contentView = pipViewController.view!
        XCTAssertEqual(contentView.frame, CGRect(x: 0.0, y: 0.0, width: 80, height: 120))
    }
    
    func testPictureInPictureAfterLoad() {
        let primaryViewController = MockViewController()
        viewController.setPrimary(primaryViewController)
        
        loadView()
        let mockViewController = MockViewController()
        viewController.setPictureInPicture(mockViewController)
        XCTAssert(viewController.pictureInPictureViewController === mockViewController)
    }


    
    @discardableResult func loadView() -> UIView {
        return viewController.view
    }
    
    func resizeView(_ size: CGSize) {
        viewController.view.frame.size = size
        viewController.view.setNeedsLayout()
    }

}
