//
//  ServiceManager.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation
import Alamofire

protocol MoviesServiceProtocol {
    func getNowPlayingMovies(completionHandler: @escaping (MoviesResult) -> ())
    func getUpcomingMovies(completionHandler: @escaping (MoviesResult) -> ()) //page?
    func getSearchMovie(query: String, completionHandler: @escaping (MoviesResult) -> ())
    func getMovieDetail(movieID: Int, completionHandler: @escaping (MovieDetailResult) -> ())
}

struct MoviesService: MoviesServiceProtocol {
    
    func getNowPlayingMovies(completionHandler: @escaping (MoviesResult) -> ()) {
        NetworkManager.shared.request(Router.nowPlaying, decodeToType: MoviesResponse.self, completionHandler: completionHandler)
    }
    
    func getUpcomingMovies(completionHandler: @escaping (MoviesResult) -> ()) {
        NetworkManager.shared.request(Router.upcoming, decodeToType: MoviesResponse.self, completionHandler: completionHandler)
    }
    
    func getSearchMovie(query: String, completionHandler: @escaping (MoviesResult) -> ()) {
        NetworkManager.shared.request(Router.search(query: query), decodeToType: MoviesResponse.self, completionHandler: completionHandler)
    }
    
    func getMovieDetail(movieID: Int, completionHandler: @escaping (MovieDetailResult) -> ()) {
        NetworkManager.shared.request(Router.detail(movieID: movieID), decodeToType: MovieDetailResponse.self, completionHandler: completionHandler)
    }
    
}

