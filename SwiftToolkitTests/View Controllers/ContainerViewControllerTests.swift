//
//  ContainerViewControllerTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class ContainerViewControllerTests: XCTestCase {
    
    var viewController: ContainerViewController!
    
    override func setUp() {
        viewController = ContainerViewController()
    }
    
    override func tearDown() {
        viewController = nil
    }
    
    func testEmptyContainerViewController() {
        let containerViewController = ContainerViewController()
        let view = containerViewController.view
        XCTAssertEqual(view!.subviews.count, 0)
    }
    
    func testAddViewControllerBeforeLoading() {
        let containerViewController = ContainerViewController()
        let mockViewController = MockViewController()
        containerViewController.setContent(mockViewController)
        
        let view = containerViewController.view
        XCTAssert(view!.subviews[0] === mockViewController.view)
        XCTAssert(mockViewController.parent === containerViewController)
    }
    
    func testAddViewControllerAfterLoading() {
        let containerViewController = ContainerViewController()
        let view = containerViewController.view
        
        let mockViewController = MockViewController()
        containerViewController.setContent(mockViewController)
        
        XCTAssert(view!.subviews[0] === mockViewController.view)
        XCTAssert(mockViewController.parent === containerViewController)
    }
    
    func testRemovesOldContentViewController() {
        let containerViewController = ContainerViewController()
        let view = containerViewController.view
        
        let mockViewController1 = MockViewController()
        containerViewController.setContent(mockViewController1)
        
        let mockViewController2 = MockViewController()
        containerViewController.setContent(mockViewController2)
        
        XCTAssertNil(mockViewController1.view.superview)
        XCTAssertNil(mockViewController1.parent)
        XCTAssert(view!.subviews[0] === mockViewController2.view)
        XCTAssert(mockViewController2.parent === containerViewController)
    }
    
    func testContentViewSizedCorrectly() {
        let containerViewController = ContainerViewController()
        let view = containerViewController.view
        view?.frame.size = CGSize(width: 150, height: 250)
        
        let mockViewController = MockViewController()
        containerViewController.setContent(mockViewController)
        
        XCTAssertEqual(mockViewController.view.frame, CGRect(x: 0, y: 0, width: 150, height: 250))
    }
    
    func testContentResizesAutomatically() {
        let containerViewController = ContainerViewController()
        let view = containerViewController.view!
        view.frame.size = CGSize(width: 150, height: 250)
        
        let mockViewController = MockViewController()
        containerViewController.setContent(mockViewController)
        
        view.frame.size = CGSize(width: 350, height: 100)
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        XCTAssertEqual(mockViewController.view.frame, CGRect(x: 0, y: 0, width: 350, height: 100))
    }
    
    func testResizeScrollViewContent() {
        let mockViewController = MockViewController()
        
        let scrollViewController = ScrollViewController()
        scrollViewController.constrainsContentToFitWidth = true
        scrollViewController.setContent(mockViewController)
        
        let containerViewController = ContainerViewController()
        containerViewController.view.backgroundColor = .white
        containerViewController.setContent(scrollViewController)
        
        containerViewController.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        containerViewController.view.setNeedsLayout()
        containerViewController.view.layoutIfNeeded()
        XCTAssertEqual(scrollViewController.view.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
        
        let navController = UINavigationController(rootViewController: containerViewController)
        navController.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        navController.view.setNeedsLayout()
        navController.view.layoutIfNeeded()
        XCTAssertEqual(scrollViewController.view.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    func testContentInsetDefaultsToZero() {
        XCTAssertEqual(viewController.contentInset, .zero)
    }
    
    func testContentInsetUniform() {
        let uniform = ContainerViewController.ContentInset.uniform(10.0)
        
        var expected = ContainerViewController.ContentInset()
        expected.top = 10.0
        expected.bottom = 10.0
        expected.left = 10.0
        expected.right = 10.0
        
        XCTAssertEqual(uniform, expected)
    }
    
    func testInsetsContentBeforeLoad() {
        viewController.contentInset = .uniform(8.0)
        
        let mockViewController = MockViewController()
        viewController.setContent(mockViewController)
        resizeView(CGSize(width: 100, height: 100))
        
        XCTAssertEqual(mockViewController.view.frame, CGRect(x: 8.0, y: 8.0, width: 84, height: 84))
    }
    
    func testInsetsContentAfterLoad() {
        let mockViewController = MockViewController()
        viewController.setContent(mockViewController)
        resizeView(CGSize(width: 100, height: 100))
        
        viewController.contentInset = .uniform(8.0)
        viewController.view.layoutIfNeeded()
        XCTAssertEqual(mockViewController.view.frame, CGRect(x: 8.0, y: 8.0, width: 84, height: 84))
    }
    
    func testCornerRadiusBeforeLoad() {
        viewController.cornerRadius = 10.0
        loadView()
        XCTAssertEqual(viewController.view.layer.cornerRadius, 10.0)
    }
    
    func testCornerRadiusAfterLoad() {
        loadView()
        viewController.cornerRadius = 10.0
        XCTAssertEqual(viewController.view.layer.cornerRadius, 10.0)
    }
    
    func testMasksToBoundsDefaultsToFalse() {
        XCTAssertFalse(viewController.masksToBounds)
        loadView()
        XCTAssertFalse(viewController.view.layer.masksToBounds)
    }
    
    func testMasksToBoundsBeforeLoad() {
        viewController.masksToBounds = true
        loadView()
        XCTAssertTrue(viewController.view.layer.masksToBounds)
    }
    
    func testMasksToBoundsAfterLoad() {
        loadView()
        viewController.masksToBounds = true
        XCTAssertTrue(viewController.view.layer.masksToBounds)
    }
    
    @discardableResult func loadView() -> UIView {
        return viewController.view
    }
    
    func resizeView(_ size: CGSize) {
        viewController.view.frame.size = size
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
    }
}

