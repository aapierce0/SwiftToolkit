//
//  StackViewControllerTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class StackViewControllerTests: XCTestCase {
    
    var viewController: StackViewController!
    
    override func setUp() {
        viewController = StackViewController()
    }
    
    override func tearDown() {
        viewController = nil
    }

    func testLoadsStackView() {
        let _ = viewController.view
        XCTAssertNotNil(viewController.stackView)
        XCTAssert(viewController.view.subviews[0] is UIStackView)
        XCTAssert(viewController.view.subviews[0] === viewController.stackView)
    }
    
    func testStackViewResizesAppropriately() {
        setViewSize(CGSize(width: 200, height: 200))
        XCTAssertEqual(viewController.stackView.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
        
        setViewSize(CGSize(width: 50, height: 400))
        XCTAssertEqual(viewController.stackView.frame, CGRect(x: 0, y: 0, width: 50, height: 400))
    }
    
    func testStackViewIsEmptyByDefault() {
        loadView()
        XCTAssertEqual(viewController.stackView.subviews.count, 0)
        XCTAssertEqual(viewController.stackView.arrangedSubviews.count, 0)
    }
    
    func testAppendViewControllerBeforeLoad() {
        let mockViewController = MockViewController()
        viewController.append(mockViewController)
        loadView()
        XCTAssert(viewController.stackView.arrangedSubviews[0] === mockViewController.view)
        XCTAssert(mockViewController.view.superview === viewController.stackView)
    }
    
    func testAppendViewControllerAfterLoad() {
        loadView()
        let mockViewController = MockViewController()
        viewController.append(mockViewController)
        XCTAssert(viewController.stackView.arrangedSubviews[0] === mockViewController.view)
        XCTAssert(mockViewController.view.superview === viewController.stackView)
    }
    
    func testAppendMultipleViewControllersBeforeLoad() {
        let mockViewController1 = MockViewController()
        viewController.append(mockViewController1)
        let mockViewController2 = MockViewController()
        viewController.append(mockViewController2)
        
        loadView()
        
        XCTAssert(viewController.stackView.arrangedSubviews[0] === mockViewController1.view)
        XCTAssert(viewController.stackView.arrangedSubviews[1] === mockViewController2.view)
    }
    
    func testAppendMultipleViewControllerAfterLoad() {
        loadView()
        
        let mockViewController1 = MockViewController()
        viewController.append(mockViewController1)
        let mockViewController2 = MockViewController()
        viewController.append(mockViewController2)
        
        XCTAssert(viewController.stackView.arrangedSubviews[0] === mockViewController1.view)
        XCTAssert(viewController.stackView.arrangedSubviews[1] === mockViewController2.view)
    }
    
    func testInsertViewControllerAtIndexBeforeLoad() {
        let existingViewController = MockViewController()
        viewController.append(existingViewController)
        
        let mockViewController = MockViewController()
        viewController.insert(mockViewController, at: 0)
        
        loadView()
        
        XCTAssert(viewController.stackView.arrangedSubviews[0] === mockViewController.view)
        XCTAssert(viewController.arrangedViewControllers[0] === mockViewController)
    }
    
    
    func testInsertViewControllerAtIndexAfterLoad() {
        loadView()

        let existingViewController = MockViewController()
        viewController.append(existingViewController)
        
        let mockViewController = MockViewController()
        viewController.insert(mockViewController, at: 0)
        
        XCTAssert(viewController.stackView.arrangedSubviews[0] === mockViewController.view)
        XCTAssert(viewController.arrangedViewControllers[0] === mockViewController)
    }
    
    func testRemoveViewControllerBeforeLoad() {
        let mockViewController = MockViewController()
        viewController.append(mockViewController)
        
        viewController.removeViewController(at: 0)
        
        loadView()
        
        XCTAssertEqual(viewController.arrangedViewControllers.count, 0)
        XCTAssertEqual(viewController.stackView.arrangedSubviews.count, 0)
        XCTAssertEqual(viewController.stackView.subviews.count, 0)
        XCTAssertNil(mockViewController.parent)
    }
    
    func testRemoveViewControllerAfterLoad() {
        loadView()
        
        let mockViewController = MockViewController()
        viewController.append(mockViewController)
        
        viewController.removeViewController(at: 0)
        
        XCTAssertEqual(viewController.arrangedViewControllers.count, 0)
        XCTAssertEqual(viewController.stackView.arrangedSubviews.count, 0)
        XCTAssertEqual(viewController.stackView.subviews.count, 0)
        XCTAssertNil(mockViewController.parent)
    }
    
    
    func testStackViewLayout() {
        setViewSize(CGSize(width: 100, height: 200))
        viewController.stackView.distribution = .fillEqually
        viewController.stackView.axis = .vertical
        
        let mockViewController1 = MockViewController()
        viewController.append(mockViewController1)
        
        let mockViewController2 = MockViewController()
        viewController.append(mockViewController2)
        
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        
        XCTAssertEqual(mockViewController1.view.frame, CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertEqual(mockViewController2.view.frame, CGRect(x: 0, y: 100, width: 100, height: 100))
        
        mockViewController1.view.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        viewController.stackView.distribution = .fill
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        
        XCTAssertEqual(mockViewController1.view.frame, CGRect(x: 0, y: 0, width: 100, height: 25))
        XCTAssertEqual(mockViewController2.view.frame, CGRect(x: 0, y: 25, width: 100, height: 175))
    }
    
    
    
    @discardableResult func loadView() -> UIView {
        return viewController.view
    }
    
    func setViewSize(_ size: CGSize) {
        viewController.view.frame.size = size
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
    }

}
