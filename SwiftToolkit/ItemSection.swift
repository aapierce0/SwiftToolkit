//
//  ItemSection.swift
//  SwiftToolbox
//
//  Created by Avery Pierce on 2/12/18.
//

import Foundation

/// Defines a section of items with a title. Useful for table views
public struct ItemSection<Item> {
    public var title: String? = nil
    public var footer: String? = nil
    public var items: [Item] = []
    
    public init(title: String? = nil, items: [Item] = []) {
        self.title = title
        self.items = items
        self.footer = nil
    }
}

public extension ItemSection {
    func map<T>(_ transform: (Item) throws -> T) rethrows -> ItemSection<T> {
        let newItems = try items.map(transform)
        return ItemSection<T>(title: title, items: newItems)
    }
}

extension ItemSection : Equatable where Item : Equatable {}

extension ItemSection : Hashable where Item : Hashable {}

