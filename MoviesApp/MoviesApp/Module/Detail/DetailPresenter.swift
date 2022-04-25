//
//  DetailPresenter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 25.04.2022.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol?
    let interactor: DetailInteractorProtocol?
    
    private var movieDetail: MovieDetailResponse?
    
    init(view: DetailViewControllerProtocol?, router: DetailRouterProtocol?, interactor: DetailInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    fileprivate func fetchMovieDetail(with movieID: Int) {
        view?.showLoadingView()
        interactor?.fetchMovieDetail(with: movieID)
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func viewDidLoad() {
        fetchMovieDetail(with: view?.getMovie()?.id ?? 0)
    }
    
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    
    func fetchMovieDetailOutput(result: MovieDetailResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let detailResult):
            movieDetail = detailResult
        case .failure(let error):
            print(error)
        }
    }

}
