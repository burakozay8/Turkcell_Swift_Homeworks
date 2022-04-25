//
//  HomeInteractor.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func fetchNowPlayingMovies()
    func fetchUpcomingMovies()
    func fetchSearch()
    //search, refresh...?
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchNowPlayingMoviesOutput(result: MoviesResult)
    func fetchUpcomingMoviesOutput(result: MoviesResult)
    //search?
}

typealias MoviesResult = Result<MoviesResponse, Error>
fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchNowPlayingMovies() {
        moviesService.getNowPlayingMovies { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchNowPlayingMoviesOutput(result: result)
        }
    }
    
    func fetchUpcomingMovies() {
        moviesService.getUpcomingMovies { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchUpcomingMoviesOutput(result: result)
        }
    }
    
    func fetchSearch() {
        moviesService.getSearchMovie(query: "cars") { [weak self] result in
            guard let self = self else { return }
            //
        }
    }
    
}
