//
//  FormTableViewControllerTests.swift
//  SwiftToolkitTests
//
//  Created by Avery Pierce on 1/9/19.
//  Copyright © 2019 Avery Pierce. All rights reserved.
//

import XCTest
@testable import SwiftToolkit

class FormTableViewControllerTests: XCTestCase {
    
    var viewController: FormTableViewController!

    override func setUp() {
        viewController = FormTableViewController()
    }

    override func tearDown() {
        viewController = nil
    }

    func testViewIsLoaded() {
        loadView()
        XCTAssertNotNil(viewController.viewIfLoaded)
    }
    
    func testFormRowHasCorrectDefaults() {
        let row = FormTableViewController.Row(identifier: "TestRow")
        XCTAssertEqual(row.identifier, "TestRow")
        XCTAssertEqual(row.keyboardType, .default)
        XCTAssertEqual(row.value, nil)
        XCTAssertEqual(row.placeholder, nil)
        XCTAssertEqual(row.label, nil)
    }
    
    func testFormConfiguresRow() {
        
        viewController.sections = [createMockSection()]
        loadView()
        resize(CGSize(width: 500, height: 200))
        
        let cell = viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FormTableViewCell
        XCTAssertEqual(cell.textField.text, "")
        XCTAssertEqual(cell.textField.placeholder, "Foo")
    }
    
    func testFormHasSectionHeader() {
        
        viewController.sections = [createMockSection()]
        loadView()
        resize(CGSize(width: 500, height: 200))
        
        let headerView = viewController.tableView.headerView(forSection: 0)
        XCTAssertEqual(headerView?.textLabel?.text, "Hello Header")
    }
    
    func testFormSectionFooter() {
        viewController.sections = [createMockSection()]
        loadView()
        resize(CGSize(width: 500, height: 200))
        
        let footerView = viewController.tableView.footerView(forSection: 0)
        XCTAssertEqual(footerView?.textLabel?.text, "Hello Footer")
    }

    func loadView() {
        let _ = viewController.view
    }
    
    func resize(_ size: CGSize) {
        viewController.view.frame.size = size
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
    }
    
    func createMockRow() -> FormTableViewController.Row {
        var row = FormTableViewController.Row(identifier: "TestRow")
        row.placeholder = "Foo"
        return row
    }
    
    func createMockSection() -> ItemSection<FormTableViewController.Row> {
        let rows = [createMockRow()]
        var section = ItemSection(title: "Hello Header", items: rows)
        section.footer = "Hello Footer"
        return section
    }
}
