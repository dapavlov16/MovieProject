//
//  MovieProjectUITests.swift
//  MovieProjectUITests
//
//  Created by Дмитрий Павлов on 02.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import XCTest

class MovieProjectUITests: XCTestCase {

    private enum Constants {
        static let favoritesTabIndex = 1
        static let searchTabIndex = 2
    }
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    func testTrendingScreenFlow() {
        let trendingCollectionView = app.collectionViews.element
        openDetails(from: trendingCollectionView)
        app.navigationBars.buttons["Back"].tap()
        app.segmentedControls.firstMatch.buttons["Популярное"].tap()
        openDetails(from: trendingCollectionView)
    }
    
    func testFavoritesScreenFlow() {
        let trendingCollectionView = app.collectionViews.element
        openDetails(from: trendingCollectionView)
        let title = app.staticTexts.firstMatch.label
        app.buttons["В избранное"].tap()
        app.tabBars.buttons.element(boundBy: Constants.favoritesTabIndex).tap()
        let favoritesTable = app.tables.element
        XCTAssert(favoritesTable.staticTexts[title].exists)
    }
    
    func testSearchScreenFlow() {
        app.tabBars.buttons.element(boundBy: Constants.searchTabIndex).tap()
        let searchBar = app.searchFields.firstMatch
        searchBar.tap()
        searchBar.typeText("Snatch")
        let searchTable = app.tables.element
        openDetails(from: searchTable)
    }

    private func openDetails(from collection: XCUIElement) {
        XCTAssert(collection.exists)
        let cell = collection.cells.firstMatch
        XCTAssert(cell.exists)
        let title = cell.staticTexts.firstMatch.label
        cell.tap()
        let detailsTitle = app.staticTexts[title]
        XCTAssert(detailsTitle.exists)
    }
}
