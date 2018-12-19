//
//  CALayerTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/18/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class CALayerTests: XCTestCase {
    
    var layer: CALayer!
    
    override func setUp() {
        let view = UIView()
        layer = view.layer
    }
    
    override func tearDown() {
        layer = nil
    }

    func testShadowGetter() {
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.blue.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 2.0)
        layer.shadowRadius = 10.0
        layer.shadowPath = nil
        
        let shadow = layer.shadow
        XCTAssertEqual(shadow.opacity, 0.5)
        XCTAssertEqual(shadow.color, UIColor.blue.cgColor)
        XCTAssertEqual(shadow.uiColor, UIColor.blue)
        XCTAssertEqual(shadow.offset, CGSize(width: 5.0, height: 2.0))
        XCTAssertEqual(shadow.radius, 10.0)
        XCTAssertNil(shadow.path)
    }

    func testShadowSetter() {
        var shadow = ShadowDescriptor.none
        shadow.opacity = 0.5
        shadow.uiColor = .blue
        shadow.offset = CGSize(width: 5.0, height: 2.0)
        shadow.radius = 10.0
        shadow.path = nil
        
        layer.shadow = shadow
        
        XCTAssertEqual(layer.shadowOpacity, 0.5)
        XCTAssertEqual(layer.shadowColor, UIColor.blue.cgColor)
        XCTAssertEqual(layer.shadowOffset, CGSize(width: 5.0, height: 2.0))
        XCTAssertEqual(layer.shadowRadius, 10.0)
        XCTAssertNil(layer.shadowPath)
    }
    
    func testBorderGetter() {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.blue.cgColor
        
        let border = layer.border
        XCTAssertEqual(border.width, 2.0)
        XCTAssertEqual(border.color, UIColor.blue.cgColor)
    }
    
    func testBorderSetter() {
        var border = BorderDescriptor()
        border.width = 2.0
        border.color = UIColor.blue.cgColor

        layer.border = border
        
        XCTAssertEqual(layer.borderWidth, 2.0)
        XCTAssertEqual(layer.borderColor, UIColor.blue.cgColor)
        
    }

}
