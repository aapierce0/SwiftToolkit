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
    
    func testAppendViewController() {
        let mockViewController = MockViewController()
        viewController.append(mockViewController)
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
