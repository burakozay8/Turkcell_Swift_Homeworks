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
    var isTopCollectionViewReloaded = false
    var isBottomCollectionViewCreated = false
    var isBottomCollectionViewReloaded = false
    var isHideLoadingInvoked = false
    var isTableViewCreated = false
    var isTableViewReloaded = false
    
    func reloadDataForTopCollectionView() {
        isTopCollectionViewReloaded = true
    }
    
    func reloadDataForBottomCollectionView() {
        isBottomCollectionViewReloaded = true
    }
    
    func showLoadingView() {}
    
    func hideLoadingView() {
        isHideLoadingInvoked = true
    }
    
    func setupCollectionViews() {
        isTopCollectionViewCreated = true
        isBottomCollectionViewCreated = true
    }
    
    func setupTableView() {
        isTableViewCreated = true
    }
    
    func reloadDataForTableView() {
        isTableViewReloaded = true
    }
    
}
