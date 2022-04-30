//
//  MockHomeInteractor.swift
//  MoviesAppTests
//
//  Created by Burak Ozay on 29.04.2022.
//

import Foundation
@testable import MoviesApp

final class MockHomeInteractor: HomeInteractorProtocol {
    
    var isFetchNowPlayingMoviesInvoked = false
    var invokedFetchNowPlayingMoviesCount = 0
    
    var isFetchUpcomingMoviesInvoked = false
    var invokedFetchUpcomingMoviesCount = 0
    
    var isFetchSearchMovieInvoked = false
    var invokedFetchSearchMovieCount = 0
    
    func fetchNowPlayingMovies() {
        isFetchNowPlayingMoviesInvoked = true
        invokedFetchNowPlayingMoviesCount += 1
    }
    
    func fetchUpcomingMovies() {
        isFetchUpcomingMoviesInvoked = true
        invokedFetchUpcomingMoviesCount += 1
    }
    
    func fetchSearchMovie(with query: String) {
        isFetchSearchMovieInvoked = true
        invokedFetchSearchMovieCount += 1
    }
    
}
