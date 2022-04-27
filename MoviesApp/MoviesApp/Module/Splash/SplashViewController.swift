//
//  SplashViewController.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

final class SplashViewController: BaseViewController {

    var presenter: SplashPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidAppear()
    }

}

extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
        showAlertForInternetConnection(title: "Network anomaly", message: "Please check your internet connection.")
    }
    
}
