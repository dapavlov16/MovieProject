//
//  MovieProjectUITests.swift
//  MovieProjectUITests
//
//  Created by Дмитрий Павлов on 02.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import XCTest

class MovieProjectUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    func testTrendingScreenFlow() {
        openDetails()
        app.navigationBars.buttons["Back"].tap()
        app.segmentedControls.firstMatch.buttons["Популярное"].tap()
        openDetails()
    }

    private func openDetails() {
        let collectionView = app.collectionViews.element
        XCTAssert(collectionView.exists)
        let cell = collectionView.cells.firstMatch
        XCTAssert(cell.exists)
        let title = cell.staticTexts.firstMatch.label
        cell.tap()
        let detailsTitle = app.staticTexts[title]
        XCTAssert(detailsTitle.exists)
    }
}
