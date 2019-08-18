//
//  SimpleMapExampleUITests.swift
//  SimpleMapExampleUITests
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import XCTest

/// here aren't full complect of tests, just couple of examples
class SimpleMapExampleUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = true
        XCUIApplication().launch()
    }

    override func tearDown() {
    }

    func testUiElementCounts() {
        XCTAssertGreaterThan(XCUIApplication().tables.cells.count, 3)
        let cell = XCUIApplication().tables.cells.element(boundBy: 3)
        XCTAssertEqual(cell.staticTexts.count, 2)
        XCTAssertEqual(cell.buttons.count, 1)
    }
    
    func testTransitionFromCell() {
        let app = XCUIApplication()
        let cell = app.tables.cells.element(boundBy: 3)
        let title = cell.staticTexts.element(boundBy: 0).label
        let description = cell.staticTexts.element(boundBy: 1).label
        
        XCTAssertEqual(app.staticTexts.matching(identifier: title).count, 1)
        XCTAssertEqual(app.staticTexts.matching(identifier: description).count, 1)
        
        /// open up the details check if there are two the same title(cell and allert title) but other text from the cell is still one
        cell.buttons.firstMatch.tap()
        XCTAssertEqual(app.staticTexts.matching(identifier: title).count, 2)
        XCTAssertEqual(app.staticTexts.matching(identifier: description).count, 1)
        
        /// close details
        app.buttons["Ok"].tap()
        XCTAssertEqual(app.staticTexts.matching(identifier: title).count, 1)
        XCTAssertEqual(app.staticTexts.matching(identifier: description).count, 1)
    }
    
    func testTransitionToMapTab() {
        let app = XCUIApplication()
        let cell = app.tables.cells.element(boundBy: 2)
        let title = cell.staticTexts.element(boundBy: 0).label
        app.tabBars.buttons["CarsMap"].tap()
        
        /// check if annotation pin exist
        let annotation = app.windows.element.otherElements[title]
        XCTAssertTrue(annotation.exists)
    }

}
