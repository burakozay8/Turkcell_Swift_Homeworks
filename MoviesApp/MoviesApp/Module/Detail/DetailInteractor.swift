//
//  DetailInteractor.swift
//  MoviesApp
//
//  Created by Burak Ozay on 25.04.2022.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    func fetchMovieDetail(with movieID: Int)
    // func refreshMovieDetail...??
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func fetchMovieDetailOutput(result: MovieDetailResult)
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
    
}
