//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reloadDataForTopCollectionView()
    func reloadDataForBottomCollectionView()
    func showLoadingView()
    func hideLoadingView()
    func setupCollectionViews()
//    var currentPage: Int { get set }
    //TODO: SearchBar?!
}

final class HomeViewController: UIViewController, LoadingShowable {
    
    var presenter: HomePresenterProtocol?
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }  //presentera taşınmalı.
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension HomeViewController: HomeViewControllerProtocol {

    func reloadDataForTopCollectionView() {
        topCollectionView.reloadData()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            self?.topCollectionView.scrollToItem(at: .init(row: 3, section: 0), at: .centeredHorizontally, animated: true)
//            self?.currentPage = 3
//        }

    }
    
    func reloadDataForBottomCollectionView() {
        bottomCollectionView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupCollectionViews() {
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        topCollectionView.register(cellType: NowPlayingMovieCell.self)
        bottomCollectionView.register(cellType: UpcomingMoviesCell.self)
    }
    
//    var currentPage: Int {
//        get {
//            0
//        }
//        set {
//            pageControl.currentPage
//        }
//    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            return presenter?.numberOfItemsForNowPlayingMovies ?? 0
        } else {
            return presenter?.numberOfItemsForUpcomingMovies ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView {
            let topCell = topCollectionView.dequeCell(cellType: NowPlayingMovieCell.self, indexPath: indexPath)
            if let nowPlayingMovie = presenter?.nowPlayingMovie(indexPath.row) {
                topCell.cellPresenter = NowPlayingMoviceCellPresenter(view: topCell, movie: nowPlayingMovie)
            }
            return topCell
        } else {
            let bottomCell = bottomCollectionView.dequeCell(cellType: UpcomingMoviesCell.self, indexPath: indexPath)
            if let upcomingMovie = presenter?.upcomingMovie(indexPath.row) {
                bottomCell.cellPresenter = UpcomingMoviesCellPresenter(view: bottomCell, movie: upcomingMovie)
            }
            return bottomCell
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topCollectionView {
            presenter?.didSelectItemAtForNowPlayingMovies(index: indexPath.row)
        } else {
            presenter?.didSelectItemAtForUpcomingMovies(index: indexPath.row)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == topCollectionView {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x / width) //
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bottomCollectionView {
            return CGSize(width: UIScreen.main.bounds.width - 50, height: 120)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bottomCollectionView {
            return 16
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == bottomCollectionView {
            return UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
}
