//
//  ItemSectionBuilder.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/12/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation

public class ItemSectionBuilder<Item : Sectionable> {
    public typealias SortFunction = (_ lhs: Item, _ rhs: Item) -> Bool
    
    let items: [Item]
    let sortFunction: SortFunction?
    
    private var sortedItems: [Item]!
    private var itemGroups: [String: [Item]] = [:]
    private var nilItemGroup: [Item] = []
    private var itemSections: [ItemSection<Item>]!
    
    init(_ items: [Item], sortedBy sortFunction: SortFunction? = nil) {
        self.items = items
        self.sortFunction = sortFunction
    }
    
    func build() -> [ItemSection<Item>] {
        sortItemsIfNeeded()
        seperateItemsIntoGroups()
        convertItemGroupsToSections()
        sortItemSectionsIfNeeded()
        return itemSections
    }
    
    private func sortItemsIfNeeded() {
        if let sortFunction = sortFunction {
            sortedItems = items.sorted(by: sortFunction)
        } else {
            sortedItems = items
        }
    }
    
    private func seperateItemsIntoGroups() {
        sortedItems.forEach(appendItemToDesignatedGroup)
    }
    
    private func appendItemToDesignatedGroup(_ item: Item) {
        if let groupTitle = item.sectionTitle {
            appendItem(item, toGroupTitled: groupTitle)
        } else {
            nilItemGroup.append(item)
        }
    }
    
    private func appendItem(_ item: Item, toGroupTitled groupTitle: String) {
        var group = itemGroups[groupTitle] ?? []
        group.append(item)
        itemGroups[groupTitle] = group
    }
    
    private func convertItemGroupsToSections() {
        let sortedKeys = itemGroups.keys.sorted()
        itemSections = sortedKeys.map({ (key) -> ItemSection<Item> in
            let items = itemGroups[key]!
            return ItemSection<Item>(title: key, items: items)
        })
        
        if nilItemGroup.count > 0 {
            let nilItemSection = ItemSection<Item>(title: nil, items: nilItemGroup)
            itemSections.append(nilItemSection)
        }
    }
    
    private func sortItemSectionsIfNeeded() {
        if let sortFunction = sortFunction {
            
            // Sort the sections by comparing the first item in each section
            itemSections.sort { (lhs, rhs) -> Bool in
                guard let lhsFirst = lhs.items.first, let rhsFirst = rhs.items.first else { return true }
                return sortFunction(lhsFirst, rhsFirst)
            }
        }
    }
}
