//
//  BorderDescriptorTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/19/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class BorderDescriptorTests: XCTestCase {

    func testInitializer() {
        let border = BorderDescriptor()
        
        XCTAssertNil(border.color)
        XCTAssertEqual(border.width, 0.0)
    }
    
    func testNone() {
        let border = BorderDescriptor.none
        
        XCTAssertNil(border.color)
        XCTAssertEqual(border.width, 0.0)
    }
    
    func testHairline() {
        let border = BorderDescriptor.hairline
        
        XCTAssertEqual(border.color, UIColor.black.cgColor)
        XCTAssertEqual(border.width, .hairline)
    }


}
