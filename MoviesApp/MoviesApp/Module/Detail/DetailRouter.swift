//
//  DetailRouter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 25.04.2022.
//

import Foundation

protocol DetailRouterProtocol: AnyObject {
    func navigate(_ route: DetailRoutes)
}

enum DetailRoutes {
    case detail(similarMovie: MovieResult)
}

final class DetailRouter {
    
    weak var viewController: DetailViewController?
    
    static func createModule() -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension DetailRouter: DetailRouterProtocol {
    
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .detail(similarMovie: let similarMovie):
            let detailVC = DetailRouter.createModule()
            detailVC.movie = similarMovie
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
