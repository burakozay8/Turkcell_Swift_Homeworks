//
//  SplashInteractor.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation

protocol SplashInteractorProtocol: AnyObject {
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol: AnyObject {
    func internetConnection(status: Bool)
}

final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol {
    
    func checkInternetConnection() {
        let internetStatus = NetworkManager.shared.isConnectedToInternet()
        self.output?.internetConnection(status: internetStatus)
    }
    
}
