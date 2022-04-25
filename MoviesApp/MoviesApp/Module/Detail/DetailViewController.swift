//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Burak Ozay on 25.04.2022.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func getMovie() -> MovieResult?
    //TODO: SearchBar?!
}

final class DetailViewController: UIViewController, LoadingShowable {

    var presenter: DetailPresenterProtocol?
    var movie: MovieResult?
    var movieDetail: MovieDetailResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension DetailViewController: DetailViewControllerProtocol {
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func getMovie() -> MovieResult? {
        return movie
    }
}
