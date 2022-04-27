//
//  SearchInteractor.swift
//  MoviesApp
//
//  Created by Burak Ozay on 27.04.2022.
//

import Foundation

protocol SearchInteractorProtocol: AnyObject {
    func fetchSearchMovie(with query: String)
    //refresh...?
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func fetchSearchMovieOutput(result: MoviesResult)
}

fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

final class SearchInteractor {
    var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorProtocol {
    
    func fetchSearchMovie(with query: String) {
        moviesService.getSearchMovie(query: query) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSearchMovieOutput(result: result)
        }
    }
    
}






