//
//  ScrollViewControllerTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class ScrollViewControllerTests: XCTestCase {
    
    var viewController: ScrollViewController!

    override func setUp() {
        viewController = ScrollViewController()
    }

    override func tearDown() {
        viewController = nil
    }
    
    func testConvenienceFunction() {
        let viewController = ScrollViewController(wrapping: MockViewController())
        let _ = viewController.view
        XCTAssertNotNil(viewController.scrollView)
        XCTAssert(viewController.scrollView.superview === viewController.view)
    }

    func testScrollViewDidLoad() {
        loadView()
        XCTAssertNotNil(viewController.scrollView)
        XCTAssert(viewController.scrollView.superview === viewController.view)
    }
    
    func testResizeScrollView() {
        loadView()
        setViewSize(CGSize(width: 120, height: 240))
        XCTAssertEqual(viewController.scrollView.frame, CGRect(x: 0, y: 0, width: 120, height: 240))
    }
    
    func testLargeContentScrolls() {
        
        let mockViewController = createMockViewController(constrainedTo: CGSize(width: 100, height: 400))
        viewController.contentContainerViewController.setContent(mockViewController)
        
        setViewSize(CGSize(width: 100, height: 100))
        
        XCTAssertEqual(viewController.scrollView.contentSize, CGSize(width: 100, height: 400))
    }
    
    func testConstrainsContentToFitWidthBeforeLoad() {
        viewController.constrainsContentToFitWidth = true
        
        let mockViewController = createMockViewController(constrainedTo: CGSize(width: 400, height: 400), priority: .defaultLow)
        
        viewController.contentContainerViewController.setContent(mockViewController)
        setViewSize(CGSize(width: 100, height: 100))
        
        XCTAssertEqual(viewController.scrollView.contentSize, CGSize(width: 100, height: 400))
    }
    
    func testConstrainsContentToFitWidth() {
        
        let mockViewController = createMockViewController(constrainedTo: CGSize(width: 400, height: 400), priority: .defaultLow)
        
        viewController.contentContainerViewController.setContent(mockViewController)
        setViewSize(CGSize(width: 100, height: 100))
        
        viewController.constrainsContentToFitWidth = true
        viewController.view.layoutIfNeeded()
        XCTAssertEqual(viewController.scrollView.contentSize, CGSize(width: 100, height: 400))
        
        viewController.constrainsContentToFitWidth = false
        viewController.view.layoutIfNeeded()
        XCTAssertEqual(viewController.scrollView.contentSize, CGSize(width: 400, height: 400))
    }
    
    func testConstrainsContentToFitHeight() {
        let mockViewController = createMockViewController(constrainedTo: CGSize(width: 400, height: 400), priority: .defaultLow)
        
        viewController.contentContainerViewController.setContent(mockViewController)
        setViewSize(CGSize(width: 100, height: 100))
        
        viewController.constrainsContentToFitHeight = true
        viewController.view.layoutIfNeeded()
        XCTAssertEqual(viewController.scrollView.contentSize, CGSize(width: 400, height: 100))
        
        viewController.constrainsContentToFitHeight = false
        viewController.view.layoutIfNeeded()
        XCTAssertEqual(viewController.scrollView.contentSize, CGSize(width: 400, height: 400))
    }
    
    
    @discardableResult func loadView() -> UIView {
        return viewController.view
    }
    
    func setViewSize(_ size: CGSize) {
        viewController.view.frame.size = size
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
    }
    
    func createMockViewController(constrainedTo size: CGSize, priority: UILayoutPriority = .required) -> MockViewController {
        let mockViewController = MockViewController()
        mockViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let mockViewWidthConstraint = mockViewController.view.widthAnchor.constraint(equalToConstant: size.width)
        mockViewWidthConstraint.priority = priority
        mockViewWidthConstraint.isActive = true
        
        let mockViewHeightConstraint = mockViewController.view.heightAnchor.constraint(equalToConstant: size.height)
        mockViewHeightConstraint.priority = priority
        mockViewHeightConstraint.isActive = true
        
        mockViewController.view.setNeedsLayout()
        mockViewController.view.layoutIfNeeded()
        
        return mockViewController
    }

}
