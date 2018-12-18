//
//  CGFloatTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/18/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest

class CGFloatTests: XCTestCase {

    func testHairline() {
        let mainScreenScale = UIScreen.main.scale
        XCTAssertEqual(CGFloat.hairline, 1.0 / mainScreenScale)
    }
    
    func testNormalizedBelowLowerBound() {
        let value: CGFloat = -10.0
        let result = value.normalized(lowerBound: 0, upperBound: 50.0)
        XCTAssertEqual(result, 0.0)
    }
    
    func testNormalizedAboveUpperBound() {
        let value: CGFloat = 80.0
        let result = value.normalized(lowerBound: 0, upperBound: 50.0)
        XCTAssertEqual(result, 1.0)
    }
    
    func testNormalizedWithinBounds() {
        let value: CGFloat = 10.0
        let result = value.normalized(lowerBound: 0, upperBound: 50.0)
        XCTAssertEqual(result, 0.2)
    }

}
