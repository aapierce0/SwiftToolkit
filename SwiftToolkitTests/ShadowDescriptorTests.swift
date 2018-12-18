//
//  ShadowDescriptorTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/18/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class ShadowDescriptorTests: XCTestCase {

    func testNone() {
        let shadow = ShadowDescriptor.none
        XCTAssertEqual(shadow.offset, CGSize.zero)
        XCTAssertEqual(shadow.radius, 0.0)
        XCTAssertEqual(shadow.color, nil)
        XCTAssertEqual(shadow.opacity, 0.0)
        XCTAssertEqual(shadow.path, nil)
    }

    func testDropSubtle() {
        let shadow = ShadowDescriptor.dropSubtle
        XCTAssertEqual(shadow.offset, CGSize(width: 0.0, height: .hairline))
        XCTAssertEqual(shadow.radius, 1.0)
        XCTAssertEqual(shadow.color, UIColor.black.cgColor)
        XCTAssertEqual(shadow.opacity, 0.2)
        XCTAssertEqual(shadow.path, nil)
    }
    
    func testDocumentDropShadow() {
        let shadow = ShadowDescriptor.documentDropShadow
        XCTAssertEqual(shadow.offset, CGSize(width: 0.0, height: .hairline))
        XCTAssertEqual(shadow.radius, 1.0)
        XCTAssertEqual(shadow.color, UIColor.black.cgColor)
        XCTAssertEqual(shadow.opacity, 0.4)
        XCTAssertEqual(shadow.path, nil)
    }
    
    func testUIColorGetter() {
        var shadow = ShadowDescriptor()
        shadow.color = UIColor.black.cgColor
        XCTAssertEqual(shadow.uiColor, UIColor.black)
    }
}
