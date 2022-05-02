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
        
        XCTAssertTrue(app.isTopCollectionViewDisplayed)
        XCTAssertTrue(app.isBottomCollectionViewDisplayed)
        XCTAssertFalse(app.isSearchTableViewDisplayed)
        
        app.searchBar.tap()
        app.searchBar.typeText("Cars")
        
        XCTAssertTrue(app.isSearchTableViewDisplayed)
//        app.keyboards.buttons["Return"].tap()
        
        app.searchCell.tap()
//
//        XCTAssertTrue(app.isTitleLabelDisplayed)
         XCTAssertTrue(app.isFavButtonDisplayed)
        //similarcollectiondisplayed.
        
    }
    
//    func test_detail_page_elements() {
//
////        app.launch()
////
////        app.UpcomingMovieCell.tap()
////
//////        XCTAssertTrue(app.isTitleLabelDisplayed)
////        XCTAssertTrue(app.isFavButtonDisplayed)
//    }
    
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}

extension XCUIApplication {
    
    var topCollectionView: XCUIElement! {
        collectionViews["topCollectionView"]
    }
    
    var bottomCollectionView: XCUIElement! {
        collectionViews["bottomCollectionView"]
    }
    
    var upcomingMovieCell: XCUIElement! {
        bottomCollectionView.cells.element(matching: .cell, identifier: "upcomingMovieCell_0")
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
        staticTexts.matching(identifier: "titleLabel").element
    }
    
    var favButton: XCUIElement! {
        buttons["favButton"]
    }
    
    var isTopCollectionViewDisplayed: Bool {
        topCollectionView.exists
    }
    
    var isBottomCollectionViewDisplayed: Bool {
        bottomCollectionView.exists
    }
    
    var isUpcomingMovieCellDisplayed: Bool {
        upcomingMovieCell.exists
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
    
}
