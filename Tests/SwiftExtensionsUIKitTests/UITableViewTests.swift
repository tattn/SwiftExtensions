//
//  UITableViewTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171213.
//  Copyright © 2017 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions
#if canImport(UIKit)
import UIKit

final class TableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

final class TableViewCell2: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

class UITableViewTests: XCTestCase {
    
    func testRegisterAndDequeueReusableCell() {
        let tableView = UITableView()
        tableView.register(cellTypes: [TableViewCell.self], bundle: .module)

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.dequeueReusableCell(with: TableViewCell.self, for: indexPath)
        XCTAssertNotNil(cell.label)
    }

    func testRegisterAndDequeueReusableMultipleCells() {
        let tableView = UITableView()
        tableView.register(cellTypes: [TableViewCell.self, TableViewCell2.self], bundle: .module)

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.dequeueReusableCell(with: TableViewCell.self, for: indexPath)
        let cell2 = tableView.dequeueReusableCell(with: TableViewCell2.self, for: indexPath)
        XCTAssertNotNil(cell.label)
        XCTAssertNotNil(cell2.label)
    }
}
#endif // canImport(UIKit)
