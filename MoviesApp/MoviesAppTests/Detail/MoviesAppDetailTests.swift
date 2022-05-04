//
//  MoviesAppDetailTests.swift
//  MoviesAppTests
//
//  Created by Burak Ozay on 30.04.2022.
//

import XCTest
@testable import MoviesApp

final class MoviesAppDetailTests: XCTestCase {

    var detailPresenter: DetailPresenter!
    var detailView: MockDetailViewController!
    var detailInteractor: MockDetailInteracor!
    var detailRouter: MockDetailRouter!
    
    override func setUp() {
        detailView = .init()
        detailInteractor = .init()
        detailRouter = .init()
        detailPresenter = .init(view: detailView, router: detailRouter, interactor: detailInteractor)
    }

    override func tearDown() {
        detailPresenter = nil
        detailView = nil
        detailInteractor = nil
        detailRouter = nil
    }
    
    func test_view_didload_invokes_required_methods() {
        XCTAssertFalse(detailView.isCollectionViewCreated, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertFalse(detailInteractor.isFetchMovieDetailInvoked, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertFalse(detailInteractor.isFetchSimilarMoviesInvoked, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertFalse(detailView.isFavButtonSet, "Your value is TRUE but you are expecting FALSE.")
        detailPresenter.viewDidLoad()
        XCTAssertTrue(detailView.isCollectionViewCreated, "Your value is FALSE but you are expecting TRUE")
        XCTAssertTrue(detailInteractor.isFetchMovieDetailInvoked, "Your value is FALSE but you are expecting TRUE.")
        XCTAssertTrue(detailInteractor.isFetchSimilarMoviesInvoked, "Your value is FALSE but you are expecting TRUE.")
        XCTAssertTrue(detailView.isFavButtonSet, "Your value is FALSE but you are expecting TRUE.")
    }
    
    func test_fetch_movie_detail() {
        XCTAssertFalse(detailView.isHideLoadingInvoked, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertFalse(detailView.isMovieDetailShown, "Your value is TRUE but you are expecting FALSE.")
        XCTAssertNil(detailView.movieDetailTitle, "Movie title did not come NIL.")
        detailPresenter.fetchMovieDetailOutput(result: .success(MovieDetailResult.movieDetailResponse))
        XCTAssertTrue(detailView.isHideLoadingInvoked, "Your value is FALSE but you are expecting TRUE.")
        XCTAssertTrue(detailView.isMovieDetailShown, "Your value is FALSE but you are expecting TRUE.")
        XCTAssertEqual(detailView.movieDetailTitle, "The Santa Clause 2")
    }
    
    func test_fetch_similar_movies() {
        XCTAssertNil(detailPresenter.similarMovie(0)?.title, "Movie title did not come NIL.")
        XCTAssertEqual(detailPresenter.numberOfItems, 0)
        XCTAssertFalse(detailView.isCollectionViewReloaded, "Your value is TRUE but you are expecting FALSE.")
        detailPresenter.fetchSimilarMovies(result: .success(MoviesResult.similarMoviesResponse))
        XCTAssertEqual(detailPresenter.similarMovie(0)?.title, "The Mothman Prophecies")
        XCTAssertEqual(detailPresenter.numberOfItems, 20)
        XCTAssertTrue(detailView.isCollectionViewReloaded, "Your value is FALSE but you are expecting TRUE.")
    }

}

extension MovieDetailResult {
    
    static var movieDetailResponse: MovieDetailResponse {
        let bundle = Bundle(for: MoviesAppDetailTests.self)
        let path = bundle.path(forResource: "MovieDetail", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieDetailResponse = try! JSONDecoder().decode(MovieDetailResponse.self, from: data)
        return movieDetailResponse
        
    }
    
}

extension MoviesResult {
    
    static var similarMoviesResponse: MoviesResponse {
        let bundle = Bundle(for: MoviesAppDetailTests.self)
        let path = bundle.path(forResource: "SimilarMovies", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MoviesResponse.self, from: data)
        return movieResponse
    }
    
}
