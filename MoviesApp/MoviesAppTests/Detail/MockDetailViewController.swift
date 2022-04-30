//
//  MockDetailViewController.swift
//  MoviesAppTests
//
//  Created by Burak Ozay on 30.04.2022.
//

import Foundation
@testable import MoviesApp

final class MockDetailViewController: DetailViewControllerProtocol {
    
    var mockMovie: MovieResult?
    
    var isCollectionViewCreated = false
    var isMovieDetailShown = false
    
    func showLoadingView() {}
    
    func hideLoadingView() {}
    
    func setupCollectionView() {
        isCollectionViewCreated = true
    }
    
    func reloadData() {}
    
    func getMovie() -> MovieResult? { return mockMovie }
    
    func showMovieDetail(_ movieDetail: MovieDetailResponse?) {
        isMovieDetailShown = true
    }
    
    func setfavButtonImage(_ systemName: String, isAdded: Bool) {}
    
    func addFavoritesButtonTapped(id: Int) {}

}
