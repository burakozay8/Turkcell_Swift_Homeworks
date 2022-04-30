//
//  DetailInteractor.swift
//  MoviesApp
//
//  Created by Burak Ozay on 25.04.2022.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    func fetchMovieDetail(with movieID: Int)
    func fetchSimilarMovies(with movieID: Int)
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func fetchMovieDetailOutput(result: MovieDetailResult)
    func fetchSimilarMovies(result: MoviesResult)
}

typealias MovieDetailResult = Result<MovieDetailResponse, Error>
fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

final class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {
    
    func fetchMovieDetail(with movieID: Int) {
        moviesService.getMovieDetail(movieID: movieID) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMovieDetailOutput(result: result)
        }
    }
    
    func fetchSimilarMovies(with movieID: Int) {
        moviesService.getSimilarMovies(movieID: movieID) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSimilarMovies(result: result)
        }
    }
    
}
