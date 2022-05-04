//
//  HomePresenter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation

protocol HomePresenterProtocol {
    func viewDidLoad()
    func searchMovie(_ text: String?)
    var numberOfItemsForNowPlayingMovies: Int { get }
    var numberOfItemsForUpcomingMovies: Int { get }
    var numberOfRowsForSearchedMovies : Int { get }
    func nowPlayingMovie(_ index: Int) -> MovieResult?
    func upcomingMovie(_ index: Int) -> MovieResult?
    func searchedMovie(_ index: Int) -> MovieResult?
    func didSelectItemAtForNowPlayingMovies(index: Int)
    func didSelectItemAtForUpcomingMovies(index: Int)
    func didSelectRowAtForSearchedMovies(index: Int)
}

final class HomePresenter {
    
    unowned var view: HomeViewControllerProtocol?
    let interactor: HomeInteractorProtocol?
    let router: HomeRouterProtocol?
    
    private var nowPlayingMovies: [MovieResult] = []
    private var upcomingMovies: [MovieResult] = []
    private var searchedMovies: [MovieResult] = []
    
    init(view: HomeViewControllerProtocol?, interactor: HomeInteractorProtocol?, router: HomeRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    fileprivate func fetchNowPlayingMovies() {
        view?.showLoadingView()
        interactor?.fetchNowPlayingMovies()
    }
    
    fileprivate func fetchUpcomingMovies() {
        interactor?.fetchUpcomingMovies()
    }
    
    fileprivate func fetchSearchMovie(with query: String) {
        interactor?.fetchSearchMovie(with: query)
    }
    
}

extension HomePresenter: HomePresenterProtocol {

    func viewDidLoad() {
        view?.setupCollectionViews()
        fetchNowPlayingMovies()
        fetchUpcomingMovies()
    }
    
    func searchMovie(_ text: String?) {
        view?.setupTableView()
        fetchSearchMovie(with: text ?? "")
    }
    
    var numberOfItemsForNowPlayingMovies: Int {
        6 
    }
    
    var numberOfItemsForUpcomingMovies: Int {
        upcomingMovies.count
    }
    
    var numberOfRowsForSearchedMovies: Int {
        searchedMovies.count
    }
    
    func nowPlayingMovie(_ index: Int) -> MovieResult? {
        nowPlayingMovies[safe: index]
    }
    
    func upcomingMovie(_ index: Int) -> MovieResult? {
        upcomingMovies[safe: index]
    }
    
    func searchedMovie(_ index: Int) -> MovieResult? {
        searchedMovies[safe: index]
    }
    
    func didSelectItemAtForNowPlayingMovies(index: Int) {
        guard let nowPlayingMovie = nowPlayingMovie(index) else { return }
        router?.navigate(.detail(movie: nowPlayingMovie))
    }
    
    func didSelectItemAtForUpcomingMovies(index: Int) {
        guard let upcomingMovie = upcomingMovie(index) else { return }
        router?.navigate(.detail(movie: upcomingMovie))
    }
    
    func didSelectRowAtForSearchedMovies(index: Int) {
        guard let searchedMovie = searchedMovie(index) else { return }
        router?.navigate(.detail(movie: searchedMovie))
    }
    
}

extension HomePresenter: HomeInteractorOutputProtocol {

    func fetchNowPlayingMoviesOutput(result: MoviesResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let moviesResult):
            nowPlayingMovies = moviesResult.results ?? []
            view?.reloadDataForTopCollectionView()
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchUpcomingMoviesOutput(result: MoviesResult) {
        switch result {
        case .success(let moviesResult):
            upcomingMovies = moviesResult.results ?? []
            view?.reloadDataForBottomCollectionView()
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchSearchMovieOutput(result: MoviesResult) {
        switch result {
        case .success(let moviesResult):
            searchedMovies = moviesResult.results ?? []
            view?.reloadDataForTableView()
        case .failure(let error):
            print(error)
        }
    }
    
}
