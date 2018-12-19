//
//  ViewLayerDescriptorTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/19/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class ViewLayerDescriptorTests: XCTestCase {
    
    var layer : CALayer!

    override func setUp() {
        let view = UIView()
        layer = view.layer
    }

    override func tearDown() {
        layer = nil
    }

    func testDefaultInitializer() {
        let descriptor = ViewLayerDescriptor()
        
        XCTAssertEqual(descriptor.cornerRadius, 0.0)
        XCTAssertEqual(descriptor.masksToBounds, false)
        XCTAssertEqual(descriptor.shadow, .none)
        XCTAssertEqual(descriptor.border, .none)
    }
    
    func testInitializerDescribingLayer() {
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        layer.shadow = .dropSubtle
        layer.border = .hairline
        
        let descriptor = ViewLayerDescriptor(describing: layer)
        XCTAssertEqual(descriptor.cornerRadius, 10.0)
        XCTAssertEqual(descriptor.masksToBounds, true)
        XCTAssertEqual(descriptor.shadow, .dropSubtle)
        XCTAssertEqual(descriptor.border, .hairline)
    }

}
