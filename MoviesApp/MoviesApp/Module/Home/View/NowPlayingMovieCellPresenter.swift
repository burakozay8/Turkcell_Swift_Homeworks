//
//  NowPlayingMovieCellPresenter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation

protocol NowPlayingMovieCellPresenterProtocol {
    func load()
}

final class NowPlayingMoviceCellPresenter {
    
    weak var view: NowPlayingMovieCellProtocol?
    private var movie: MovieResult?
    
    init(view: NowPlayingMovieCellProtocol?, movie: MovieResult?) {
        self.view = view
        self.movie = movie
    }
    
}

extension NowPlayingMoviceCellPresenter: NowPlayingMovieCellPresenterProtocol {
    
    func load() {
        view?.setImageView(movie?.backdropPath ?? "")
    }
    
}

