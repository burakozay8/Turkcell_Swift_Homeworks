//
//  SplashPresenter.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

final class SplashPresenter {
    
    unowned var view: SplashViewControllerProtocol?
    private let interactor: SplashInteractorProtocol?
    private let router: SplashRouterProtocol?
    
    init(view: SplashViewControllerProtocol?, interactor: SplashInteractorProtocol?, router: SplashRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension SplashPresenter: SplashPresenterProtocol {
    
    func viewDidAppear() {
        interactor?.checkInternetConnection()
    }

}

extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func internetConnection(status: Bool) {
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.router?.navigate(.homeScreen)
            }
        } else {
            self.view?.noInternetConnection()
        }
    }
    
}
