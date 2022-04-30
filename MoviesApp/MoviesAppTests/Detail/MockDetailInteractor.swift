//
//  MockDetailInteractor.swift
//  MoviesAppTests
//
//  Created by Burak Ozay on 30.04.2022.
//

import Foundation
@testable import MoviesApp

final class MockDetailInteracor: DetailInteractorProtocol {
    
    var isFetchMovieDetailInvoked = false
    var invokedFetchMovieDetailCount = 0
    
    var isFetchSimilarMoviesInvoked = false
    var invokedFetchSimilarMoviesCount = 0
    
    func fetchMovieDetail(with movieID: Int) {
        isFetchMovieDetailInvoked = true
        invokedFetchMovieDetailCount += 1
    }
    
    func fetchSimilarMovies(with movieID: Int) {
        isFetchSimilarMoviesInvoked = true
        invokedFetchSimilarMoviesCount += 1
    }
    
}
