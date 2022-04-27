//
//  SearchRouter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 27.04.2022.
//

import Foundation

protocol SearchRouterProtocol: AnyObject {
    func navigate(_ route: SearchRoutes)
}

enum SearchRoutes {
    case detail(movie: MovieResult)
}

final class SearchRouter {
    
    weak var viewController: SearchViewController?
    
    static func createModule() -> SearchViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension SearchRouter: SearchRouterProtocol {
    
    func navigate(_ route: SearchRoutes) {
//        switch route {
//        case .detail(let movie):
//            let detailVC = DetailRouter.createModule()
//            detailVC.movie = movie
//            viewController?.navigationController?.pushViewController(detailVC, animated: true)
//        }
    }
    
}
