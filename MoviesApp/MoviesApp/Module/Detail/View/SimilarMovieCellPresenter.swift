//
//  SimilarMovieCellPresenter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 26.04.2022.
//

import Foundation

protocol SimilarMovieCellPresenterProtocol {
    func load()
}

final class SimilarMovieCellPresenter {
    
    weak var view: SimilarMovieCell?
    private var similarMovie: MovieResult?
    
    init(view: SimilarMovieCell?, similarMovie: MovieResult?) {
        self.view = view
        self.similarMovie = similarMovie
    }
    
}

extension SimilarMovieCellPresenter: SimilarMovieCellPresenterProtocol {
    
    func load() {
        view?.setImageView(similarMovie?.backdropPath ?? "")
        view?.setTitleLabel(similarMovie?.title ?? "")
    }
    
}
