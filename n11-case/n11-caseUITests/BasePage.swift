//
//  BasePage.swift
//  n11-caseUITests
//
//  Created by Tolga Taner on 26.10.2025.
//

import XCTest

protocol BasePage {
    var app: XCUIApplication { get set }
    
    init(app: XCUIApplication)
    
    func checkElementsAreExists()
}
