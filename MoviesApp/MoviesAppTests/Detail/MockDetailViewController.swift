//
//  MockDetailViewController.swift
//  MoviesAppTests
//
//  Created by Burak Ozay on 30.04.2022.
//

import Foundation
@testable import MoviesApp

final class MockDetailViewController: DetailViewControllerProtocol {
    
    var mockMovie: MovieResult!
    
    var isCollectionViewCreated = false
    var isCollectionViewReloaded = false
    var isHideLoadingInvoked = false
    var isMovieDetailShown = false
    var isFavButtonSet = false
    
    var movieDetailTitle: String! = nil
    
    func showLoadingView() {}
    
    func hideLoadingView() {
        isHideLoadingInvoked = true
    }
    
    func setupCollectionView() {
        isCollectionViewCreated = true
    }
    
    func reloadData() {
        isCollectionViewReloaded = true
    }
    
    func getMovie() -> MovieResult? { return mockMovie }
    
    func showMovieDetail(_ movieDetail: MovieDetailResponse?) {
        isMovieDetailShown = true
        movieDetailTitle = (movieDetail?.originalTitle)!
    }
    
    func setfavButtonImage(_ systemName: String, isAdded: Bool) {
        isFavButtonSet = true
    }
    
    func addFavoritesButtonTapped(id: Int) {}

}
