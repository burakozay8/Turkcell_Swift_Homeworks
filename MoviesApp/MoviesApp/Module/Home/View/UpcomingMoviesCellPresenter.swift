//
//  UpcomingMoviesCellPresenter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation

protocol UpcomingMoviesCellPresenterProtcol: AnyObject {
    func load()
}

final class UpcomingMoviesCellPresenter {
    
    weak var view: UpcomingMoviesCell?
    private var movie: MovieResult?
    
    init(view: UpcomingMoviesCell?, movie: MovieResult?) {
        self.view = view
        self.movie = movie
    }
    
}

extension UpcomingMoviesCellPresenter: UpcomingMoviesCellPresenterProtcol {
    
    func load() {
        view?.setImage(movie?.posterPath ?? "")
        view?.setTitleLabel(movie?.title ?? "")
        view?.setOverviewLabel(movie?.originalTitle ?? "")
        view?.setReleaseDateLabel(movie?.releaseDate ?? "")
    }
    
}
