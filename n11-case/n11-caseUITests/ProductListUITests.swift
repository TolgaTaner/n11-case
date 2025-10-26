//
//  n11_caseUITests.swift
//  n11-caseUITests
//
//  Created by Tolga Taner on 24.10.2025.
//

import XCTest

final class ProductListUITests: XCTestCase {


    @MainActor
    func testProductListItemsExist() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let productListPage: ProductListPage = ProductListPage(app: app)
        productListPage.checkElementsAreExists()

    }

}
