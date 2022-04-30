//
//  MockHomeViewController.swift
//  MoviesAppTests
//
//  Created by Burak Ozay on 29.04.2022.
//

import Foundation
@testable import MoviesApp

final class MockHomeViewController: HomeViewControllerProtocol {
    
    var isTopCollectionViewCreated = false
    var isBottomCollectionViewCreated = false
    
    func reloadDataForTopCollectionView() {}
    
    func reloadDataForBottomCollectionView() {}
    
    func showLoadingView() {}
    
    func hideLoadingView() {}
    
    func setupCollectionViews() {
        isTopCollectionViewCreated = true
        isBottomCollectionViewCreated = true
    }
    
    func setupTableView() {}
    
    func reloadDataForTableView() {}
    
}
