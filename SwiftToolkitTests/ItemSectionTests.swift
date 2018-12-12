//
//  ItemSectionTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/12/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class ItemSectionTests: XCTestCase {

    func testInitializer() {
        let section = ItemSection<String>(title: "Mock Title", items: ["mock item 1"])
        
        XCTAssertEqual(section.title, "Mock Title")
        XCTAssertEqual(section.items, ["mock item 1"])
        XCTAssertNil(section.footer)
    }
    
    func testMap() {
        let section = ItemSection<String>(title: "Strings", items: ["mock item 1", "another mock item in the list", "hello world!"])
        let mappedSection = section.map({ (cellString) -> Int in
            return cellString.count
        })
        
        XCTAssertEqual(mappedSection.title, "Strings")
        XCTAssertEqual(mappedSection.items, [11, 29, 12])
        XCTAssertNil(mappedSection.footer)
    }
}
