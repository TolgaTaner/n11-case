//
//  ProductListPage.swift
//  n11-caseUITests
//
//  Created by Tolga Taner on 26.10.2025.
//

import XCTest

enum AccessibilityIdentifier: String {
    case productListNavigationView
    case productListTableView
    case productListContentView
    case productListHeaderView
    
    var errorMessage: String {
        "\(self.rawValue) is not shown."
    }
}


final class ProductListPage: BasePage {
    var app: XCUIApplication
    

    init(app: XCUIApplication) {
        self.app = app
    }
    
    func checkElementsAreExists() {
        let navigationView = app.otherElements[AccessibilityIdentifier.productListNavigationView.rawValue]
        let tableView = app.tables[AccessibilityIdentifier.productListTableView.rawValue]
        let contentView = app.otherElements[AccessibilityIdentifier.productListContentView.rawValue]
        let headerView = app.otherElements[AccessibilityIdentifier.productListHeaderView.rawValue]
    
        XCTAssertTrue(navigationView.exists, AccessibilityIdentifier.productListNavigationView.errorMessage)
        XCTAssertTrue(tableView.exists, AccessibilityIdentifier.productListTableView.errorMessage)
        XCTAssertTrue(contentView.exists, AccessibilityIdentifier.productListContentView.errorMessage)
        XCTAssertTrue(headerView.exists, AccessibilityIdentifier.productListHeaderView.errorMessage)
        
    }
}
