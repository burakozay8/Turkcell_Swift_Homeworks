//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Burak Ozay on 24.04.2022.
//

import XCTest
@testable import MoviesApp

class MoviesAppHomeTests: XCTestCase {
    
    var homePresenter: HomePresenter!
    var homeView: MockHomeViewController!
    var homeInteractor: MockHomeInteractor!
    var homeRouter: MockHomeRouter!

    override func setUp() {
        super.setUp()
        homeView = .init()
        homeInteractor = .init()
        homeRouter = .init()
        homePresenter = .init(view: homeView, interactor: homeInteractor, router: homeRouter)
    }

    override func tearDown() {
        homePresenter = nil
        homeView = nil
        homeInteractor = nil
        homeRouter = nil
    }

    func test_viewDidLoad_InvokesRequiredViewMethods() {
        XCTAssertFalse(homeView.isTopCollectionViewCreated, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertFalse(homeView.isBottomCollectionViewCreated, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertFalse(homeInteractor.isFetchNowPlayingMoviesInvoked, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertFalse(homeInteractor.isFetchUpcomingMoviesInvoked, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertFalse(homeInteractor.isFetchSearchMovieInvoked, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertEqual(homeInteractor.invokedFetchNowPlayingMoviesCount, 0)
        homePresenter.viewDidLoad()
        XCTAssertTrue(homeView.isTopCollectionViewCreated, "Your value is FALSE but you are expecting TRUE.")
        XCTAssertTrue(homeView.isBottomCollectionViewCreated, "Your value is FALSE but you are expecting TRUE.")
        XCTAssertTrue(homeInteractor.isFetchNowPlayingMoviesInvoked, "Your value is FALSE but you are expecting TRUE.")
        XCTAssertTrue(homeInteractor.isFetchUpcomingMoviesInvoked, "Your value is FALSE but you are expecting TRUE.")
        XCTAssertTrue(homeInteractor.isFetchSearchMovieInvoked, "Your value is FALSE but you are expecting TRUE.")
        XCTAssertEqual(homeInteractor.invokedFetchNowPlayingMoviesCount, 1) //??
    }
    
    func test_NowPlayingMovies() {
        XCTAssertNil(homePresenter.nowPlayingMovie(0)?.title, "Movie title did not come NIL.")
        XCTAssertEqual(homePresenter.numberOfItemsForNowPlayingMovies, 6)
        homePresenter.fetchNowPlayingMoviesOutput(result: .success(MoviesResult.nowPlayingMoviesResponse))
        XCTAssertEqual(homePresenter.nowPlayingMovie(0)?.title, "The Batman")
        XCTAssertEqual(homePresenter.numberOfItemsForNowPlayingMovies, 6)
    }
    
    func test_UpcomingMovies() {
        XCTAssertNil(homePresenter.upcomingMovie(0)?.title, "Movie title did not come NIL.")
        XCTAssertEqual(homePresenter.numberOfItemsForUpcomingMovies, 0)
        homePresenter.fetchUpcomingMoviesOutput(result: .success(MoviesResult.upcomingMoviesResponse))
        XCTAssertEqual(homePresenter.upcomingMovie(0)?.title, "The Outfit")
        XCTAssertEqual(homePresenter.numberOfItemsForUpcomingMovies, 20)
    }

    func test_SearchedMovies() {
        XCTAssertNil(homePresenter.searchedMovie(0)?.title, "Movie title did not come NIL.")
        XCTAssertEqual(homePresenter.numberOfRowsForSearchedMovies, 0)
        homePresenter.fetchSearchMovieOutput(result: .success(MoviesResult.searchMovieResponse))
        XCTAssertEqual(homePresenter.searchedMovie(0)?.title, "Cars")
        XCTAssertEqual(homePresenter.numberOfRowsForSearchedMovies, 20)
    }
    
}

extension MoviesResult {
    
    static var nowPlayingMoviesResponse: MoviesResponse {
        let bundle = Bundle(for: MoviesAppHomeTests.self)
        let path = bundle.path(forResource: "NowPlayingMovies", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MoviesResponse.self, from: data)
        return movieResponse
    }
    
    static var upcomingMoviesResponse: MoviesResponse {
        let bundle = Bundle(for: MoviesAppHomeTests.self)
        let path = bundle.path(forResource: "UpcomingMovies", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MoviesResponse.self, from: data)
        return movieResponse
    }
    
    static var searchMovieResponse: MoviesResponse {
        let bundle = Bundle(for: MoviesAppHomeTests.self)
        let path = bundle.path(forResource: "SearchMovie", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MoviesResponse.self, from: data)
        return movieResponse
    }

}