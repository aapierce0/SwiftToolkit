//
//  ItemSectionBuilderTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 12/12/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class ItemSectionBuilderTests: XCTestCase {

    func testBuildSections() {
        let categories = ["Cat 1", "Cat 2"]
        let mockItems = MockItemGenerator(categories: categories).generate(count: 10)
        let builder = ItemSectionBuilder(mockItems)
        let itemSections = builder.build()
        let stringifiedItemSections = itemSections.map(stringify)
        
        XCTAssertEqual(stringifiedItemSections, [
            "Cat 1|<nil>: Mock Item 0, Mock Item 2, Mock Item 4, Mock Item 6, Mock Item 8",
            "Cat 2|<nil>: Mock Item 1, Mock Item 3, Mock Item 5, Mock Item 7, Mock Item 9"
            ])
    }
    
    func testBuildSectionsWithNilOption() {
        let categories = ["Cat 1", "Cat 2", nil]
        let mockItems = MockItemGenerator(categories: categories).generate(count: 10)
        let builder = ItemSectionBuilder(mockItems)
        let itemSections = builder.build()
        let stringifiedItemSections = itemSections.map(stringify)
        
        XCTAssertEqual(stringifiedItemSections, [
            "Cat 1|<nil>: Mock Item 0, Mock Item 3, Mock Item 6, Mock Item 9",
            "Cat 2|<nil>: Mock Item 1, Mock Item 4, Mock Item 7",
            "<nil>|<nil>: Mock Item 2, Mock Item 5, Mock Item 8"
            ])
    }
    
    func testBuildSectionsWithSortingEnabled() {
        let categories = ["Cat 1", "Cat 2"]
        let mockItems = MockItemGenerator(categories: categories).generate(count: 10)
        let builder = ItemSectionBuilder(mockItems, sortedBy: { (lhs, rhs) -> Bool in
            return lhs.name > rhs.name
        })
        let itemSections = builder.build()
        let stringifiedItemSections = itemSections.map(stringify)
        
        XCTAssertEqual(stringifiedItemSections, [
            "Cat 2|<nil>: Mock Item 9, Mock Item 7, Mock Item 5, Mock Item 3, Mock Item 1",
            "Cat 1|<nil>: Mock Item 8, Mock Item 6, Mock Item 4, Mock Item 2, Mock Item 0"
            ])
    }

}

fileprivate func stringify(_ itemSection: ItemSection<MockItem>) -> String{
    let joinedItemNames = itemSection.items.map({ $0.name }).joined(separator: ", ")
    return "\(itemSection.title ?? "<nil>")|\(itemSection.footer ?? "<nil>"): \(joinedItemNames)"
}


fileprivate struct MockItem : Sectionable, Equatable {
    var name: String
    var category: String?
    
    init(name: String, category: String?) {
        self.name = name
        self.category = category
    }
    
    var sectionTitle: String? {
        return category
    }
}

fileprivate struct MockItemGenerator {
    var categories: [String?]
    init(categories: [String?]) {
        self.categories = categories
    }
    
    func generate(count: Int) -> [MockItem] {
        let indexes = 0 ..< count
        let mockItems = indexes.map { (index) -> MockItem in
            let name = "Mock Item \(index)"
            let category = selectCategory(forIndex: index)
            return MockItem(name: name, category: category)
        }
        return mockItems
    }
    
    private func selectCategory(forIndex index: Int) -> String? {
        let categoryIndex = index % categories.count
        return categories[categoryIndex]
    }
}
