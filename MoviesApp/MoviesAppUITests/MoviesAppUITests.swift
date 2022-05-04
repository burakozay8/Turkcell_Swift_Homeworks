//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Burak Ozay on 24.04.2022.
//

import XCTest

final class MoviesAppUITests: XCTestCase {

    private var app: XCUIApplication!
 
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("***** UI TEST *****")
    }
    
    func test_navigate_to_detail_view_controller() {
        
        app.launch()
        
        app.topCollectionView.waitForExistence(timeout: 2.0)
        app.bottomCollectionView.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(app.isTopCollectionViewDisplayed)
        XCTAssertTrue(app.isBottomCollectionViewDisplayed)
        XCTAssertFalse(app.isSearchTableViewDisplayed)
        
        app.searchBar.tap()

        app.keys["C"].tap()
        app.keys["a"].tap()
        app.keys["r"].tap()
        app.keys["s"].tap()
        
        XCTAssertTrue(app.isSearchTableViewDisplayed)
        
        app.searchCell.tap()

        XCTAssertTrue(app.isTitleLabelDisplayed)
        XCTAssertTrue(app.isFavButtonDisplayed)
        XCTAssertTrue(app.isSimilarMoviesCollectionViewDisplayed)
        
        app.similarMovieCell.tap()
        
        XCTAssertTrue(app.isFavButtonDisplayed)
        
        app.favButton.tap()
        
    }
    
}

extension XCUIApplication {
    
    var topCollectionView: XCUIElement! {
        collectionViews["topCollectionView"]
    }
    
    var bottomCollectionView: XCUIElement! {
        collectionViews["bottomCollectionView"]
    }
    
    var searchBar: XCUIElement! {
        otherElements["searchBar"]
    }
    
    var searchTableView: XCUIElement! {
        tables["searchTableView"]
    }
    
    var searchCell: XCUIElement! {
        searchTableView.cells.element(matching: .cell, identifier: "searchCell_0")
    }
    
    var titleLabel: XCUIElement! {
        staticTexts.matching(identifier: "movieTitleLabel").element
    }
    
    var favButton: XCUIElement! {
        buttons["favButton"]
    }
    
    var similarMoviesCollectionView: XCUIElement! {
        collectionViews["similarMoviesCollectionView"]
    }
    
    var similarMovieCell: XCUIElement! {
        similarMoviesCollectionView.cells.element(matching: .cell, identifier: "similarMovieCell_1")
    }
    
    var isTopCollectionViewDisplayed: Bool {
        topCollectionView.exists
    }
    
    var isBottomCollectionViewDisplayed: Bool {
        bottomCollectionView.exists
    }
    
    var isSearchTableViewDisplayed: Bool {
        searchTableView.exists
    }
    
    var isSearchCellDisplayed: Bool {
        searchCell.exists
    }
    
    var isTitleLabelDisplayed: Bool {
        titleLabel.exists
    }
    
    var isFavButtonDisplayed: Bool {
        favButton.exists
    }
    
    var isSimilarMoviesCollectionViewDisplayed: Bool {
        similarMoviesCollectionView.exists
    }
    
}
