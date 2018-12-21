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
    
    func testViewLoadsWithPrimaryContent() {
        let mockViewController = MockViewController()
        viewController.backgroundContainerViewController.setContent(mockViewController)
        loadView()
        XCTAssertTrue(mockViewController.isViewLoaded)
    }
    
    func testPrimaryContentResizes() {
        let mockViewController = MockViewController()
        viewController.backgroundContainerViewController.setContent(mockViewController)
        loadView()
        
        resizeView(CGSize(width: 100, height: 100))
        viewController.view.layoutIfNeeded()
        XCTAssertEqual(mockViewController.view.frame, CGRect(x: 0, y: 0, width: 100, height: 100))
        
        resizeView(CGSize(width: 200, height: 200))
        viewController.view.layoutIfNeeded()
        XCTAssertEqual(mockViewController.view.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    func testPictureInPictureIsLoaded() {
        let primaryViewController = MockViewController()
        viewController.backgroundContainerViewController.setContent(primaryViewController)
        let pipViewController = MockViewController()
        viewController.pictureInPictureContainerViewController.setContent(pipViewController)
        loadView()
        
        XCTAssertTrue(pipViewController.isViewLoaded)
    }
    
    func testPictureInPictureAppears() {
        let primaryViewController = MockViewController()
        viewController.backgroundContainerViewController.setContent(primaryViewController)
        let pipViewController = MockViewController()
        pipViewController.preferredContentSize = CGSize(width: 80, height: 120)
        viewController.pictureInPictureContainerViewController.setContent(pipViewController)
        loadView()
        resizeView(CGSize(width: 400, height: 800))
        viewController.view.layoutIfNeeded()
        
        XCTAssertEqual(viewController.view.subviews.count, 2)
        let wrapperView = viewController.view.subviews[1]
        XCTAssertEqual(wrapperView.frame, CGRect(x: 312, y: 8, width: 80, height: 120))
        
        let contentView = pipViewController.view!
        XCTAssertEqual(contentView.frame, CGRect(x: 0.0, y: 0.0, width: 80, height: 120))
    }
    
    func testPictureInPictureReactsToChangesInPreferredContentSize() {
        let primaryViewController = MockViewController()
        viewController.backgroundContainerViewController.setContent(primaryViewController)
        let pipViewController = MockViewController()
        pipViewController.preferredContentSize = CGSize(width: 80, height: 120)
        viewController.pictureInPictureContainerViewController.setContent(pipViewController)
        loadView()
        resizeView(CGSize(width: 400, height: 800))
        viewController.view.layoutIfNeeded()
        
        pipViewController.preferredContentSize = CGSize(width: 120, height: 80)
        viewController.view.layoutIfNeeded()
        
        let wrapperView = viewController.view.subviews[1]
        XCTAssertEqual(wrapperView.frame, CGRect(x: 272, y: 8, width: 120, height: 80))
        
        let contentView = pipViewController.view!
        XCTAssertEqual(contentView.frame, CGRect(x: 0.0, y: 0.0, width: 120, height: 80))
    }
    
    func testPictureInPictureAfterLoad() {
        let primaryViewController = MockViewController()
        viewController.backgroundContainerViewController.setContent(primaryViewController)
        
        loadView()
        let mockViewController = MockViewController()
        viewController.pictureInPictureContainerViewController.setContent(mockViewController)
        XCTAssert(viewController.pictureInPictureContainerViewController.contentViewController === mockViewController)
    }
    
    func testConvenienceInitializerWithNilValues() {
        let viewController = PictureInPictureViewController(background: nil, pictureInPicture: nil)
        XCTAssertNil(viewController.backgroundContainerViewController.contentViewController)
        XCTAssertNil(viewController.pictureInPictureContainerViewController.contentViewController)
    }
    
    func testConvenienceInitializerWithMockValues() {
        let mockBackground = MockViewController()
        let mockPIP = MockViewController()
        let viewController = PictureInPictureViewController(background: mockBackground, pictureInPicture: mockPIP)
        XCTAssert(viewController.backgroundContainerViewController.contentViewController === mockBackground)
        XCTAssert(viewController.pictureInPictureContainerViewController.contentViewController === mockPIP)
    }
    
    func testHidesPIPViewControllerAfterLoad() {
        resizeView(CGSize(width: 400, height: 800))
        viewController.view.layoutIfNeeded()
        viewController.hidePictureInPictureViewController()
        
        let rootBounds = viewController.view.bounds
        let pipFrame = viewController.pictureInPictureContainerViewController.view.frame
        
        XCTAssertFalse(rootBounds.intersects(pipFrame))
    }
    
    func testHidesPIPViewControllerBeforeLoad() {
        viewController.hidePictureInPictureViewController()
        
        resizeView(CGSize(width: 400, height: 800))
        viewController.view.layoutIfNeeded()
        
        let rootBounds = viewController.view.bounds
        let pipFrame = viewController.pictureInPictureContainerViewController.view.frame
        
        XCTAssertFalse(rootBounds.intersects(pipFrame))
    }
    
    func testShowsPipViewControllerAfterLoad() {
        viewController.hidePictureInPictureViewController()
        resizeView(CGSize(width: 400, height: 800))
        viewController.view.layoutIfNeeded()
        
        viewController.showPictureInPictureViewController()
        
        let rootBounds = viewController.view.bounds
        let pipFrame = viewController.pictureInPictureContainerViewController.view.frame
        XCTAssertTrue(rootBounds.intersects(pipFrame))
    }


    
    @discardableResult func loadView() -> UIView {
        return viewController.view
    }
    
    func resizeView(_ size: CGSize) {
        viewController.view.frame.size = size
        viewController.view.setNeedsLayout()
    }

}
