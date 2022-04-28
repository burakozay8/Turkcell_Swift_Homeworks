//
//  DetailPresenter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 25.04.2022.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    var numberOfItems: Int { get }
    func similarMovie(_ index: Int) -> MovieResult?
    func addFavoritesButtonTapped()
    func addFavoritesMovie(id: Int)
    func didSelectItemAt(index: Int)
//    func loadDetail()
}

final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol?
    let interactor: DetailInteractorProtocol?
    
    private var movieDetail: MovieDetailResponse?
    private var similarMovies: [MovieResult] = []
    
    private var favoriteStatus: Bool = false //modele alınabilir? mi?
    
    init(view: DetailViewControllerProtocol?, router: DetailRouterProtocol?, interactor: DetailInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    fileprivate func fetchMovieDetail(with movieID: Int) {
        view?.showLoadingView()
        interactor?.fetchMovieDetail(with: movieID)
    }
    
    fileprivate func fetchSimilarMovies(with movieID: Int) {
        interactor?.fetchSimilarMovies(with: movieID)
    }
    
    private func isAddedFavorites() -> Bool {
        favoriteStatus ? true : false
    }
    
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func viewDidLoad() {
        view?.setupCollectionView()
        fetchMovieDetail(with: view?.getMovie()?.id ?? 0)
        fetchSimilarMovies(with: view?.getMovie()?.id ?? 0)
        
        let buttonSystemName = favoriteStatus ? "star.fill" : "star"
        view?.setfavButtonImage(buttonSystemName, isAdded: isAddedFavorites())
    }
    
    var numberOfItems: Int {
        similarMovies.count
    }
    
    func similarMovie(_ index: Int) -> MovieResult? {
        similarMovies[safe: index]
    }
    
    func addFavoritesButtonTapped() {
        favoriteStatus.toggle()
        if let id = movieDetail?.id {
            view?.addFavoritesButtonTapped(id: id)
        }
        let buttonSystemName = favoriteStatus ? "star.fill" : "star"
        view?.setfavButtonImage(buttonSystemName, isAdded: !isAddedFavorites())
    }
    
    func addFavoritesMovie(id: Int) { //kayıt oluyor ama buton dolmuyor.
        if !favoriteStatus {
            print("******************** ???")
        } else {
            MovieRepository().saveMovieID(id: id)
        }
    }
    
    func didSelectItemAt(index: Int) {
        guard let similarMovie = similarMovie(index) else { return }
        router?.navigate(.detail(similarMovie: similarMovie))
    }
    
//    func loadDetail() {
////        view?.showLoadingView()
//        view?.showMovieDetail(movieDetail)
////        view?.hideLoadingView()
//    }
    
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    
    func fetchMovieDetailOutput(result: MovieDetailResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let detailResult):
            movieDetail = detailResult
            view?.showMovieDetail(movieDetail)
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchSimilarMovies(result: MoviesResult) {
        switch result {
        case .success(let moviesResult):
            similarMovies = moviesResult.results ?? []
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }

}
