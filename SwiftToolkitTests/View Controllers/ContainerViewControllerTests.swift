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
}

