//
//  HomePresenter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation

protocol HomePresenterProtocol {
    func viewDidLoad()
    var numberOfItemsForNowPlayingMovies: Int { get }
    var numberOfItemsForUpcomingMovies: Int { get }
    func nowPlayingMovie(_ index: Int) -> MovieResult?
    func upcomingMovie(_ index: Int) -> MovieResult?
    func didSelectRowAtForTopCollectionView(index: Int)
    func didSelectRowAtForBottomCollectionView(index: Int)
//    var currentPage: Int { get }
}

final class HomePresenter {
    
    unowned var view: HomeViewControllerProtocol?
    let interactor: HomeInteractorProtocol?
    let router: HomeRouterProtocol?
    
    private var nowPlayingMovies: [MovieResult] = []
    private var upcomingMovies: [MovieResult] = []
    
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
        view?.showLoadingView()
        interactor?.fetchUpcomingMovies()
    }
    
}

extension HomePresenter: HomePresenterProtocol {

    func viewDidLoad() {
        view?.setupCollectionViews()
        fetchNowPlayingMovies()
        fetchUpcomingMovies()
        fetchSearch()
    }
    
    var numberOfItemsForNowPlayingMovies: Int {
        6 
    }
    
    var numberOfItemsForUpcomingMovies: Int {
        upcomingMovies.count
    }
    
    func nowPlayingMovie(_ index: Int) -> MovieResult? {
        nowPlayingMovies[safe: index]
    }
    
    func upcomingMovie(_ index: Int) -> MovieResult? {
        upcomingMovies[safe: index]
    }
    
    func didSelectRowAtForTopCollectionView(index: Int) {
        guard let nowPlayingMovie = nowPlayingMovie(index) else { return }
        router?.navigate(.detail(movie: nowPlayingMovie))
    }
    
    func didSelectRowAtForBottomCollectionView(index: Int) {
        guard let upcomingMovie = upcomingMovie(index) else { return }
        router?.navigate(.detail(movie: upcomingMovie))
    }
    
//    var currentPage: Int {
//        view?.currentPage = currentPage
//    }
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func fetchNowPlayingMoviesOutput(result: MoviesResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let moviesResult):
            nowPlayingMovies = moviesResult.results ?? []
            view?.reloadDataForTopCollectionView() //
        case .failure(let error):
            print(error) // alert göster.
        }
    }
    
    func fetchUpcomingMoviesOutput(result: MoviesResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let moviesResult):
            upcomingMovies = moviesResult.results ?? []
            view?.reloadDataForBottomCollectionView() //
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchSearch() {
        interactor?.fetchSearch()
    }
    
}
