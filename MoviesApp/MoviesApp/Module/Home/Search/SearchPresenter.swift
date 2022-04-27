//
//  SearchPresenter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 27.04.2022.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
    var numberOfItems: Int { get }
    func searchMovie(_ index: Int) -> MovieResult?
//    func didSelectItemAt(index: Int)
}

final class SearchPresenter {
    
    unowned var view: SearchViewControllerProtocol?
    let interactor: SearchInteractorProtocol?
    let router: SearchRouterProtocol?
    
    private var moviesSearch: [MovieResult] = [] //boyle mi olmalı??

    init(view: SearchViewControllerProtocol?, interactor: SearchInteractorProtocol?, router: SearchRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
    fileprivate func fetchSearchMovie(with query: String) {
        view?.showLoadingView()
        interactor?.fetchSearchMovie(with: query)
    }
    
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func viewDidLoad() {
        view?.setupTableView()
        fetchSearchMovie(with: "cars")
    }
    
    var numberOfItems: Int {
        moviesSearch.count
    }
    
    func searchMovie(_ index: Int) -> MovieResult? {
        moviesSearch[safe: index]
    }
    
//    func didSelectItemAt(index: Int) {
//        
//    }
    
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
    func fetchSearchMovieOutput(result: MoviesResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let moviesResult):
            moviesSearch = moviesResult.results ?? []
            print(moviesSearch)
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
}
