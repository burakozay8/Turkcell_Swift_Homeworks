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
    //TODO: SearchBar?!
}

final class HomeViewController: UIViewController, LoadingShowable, UISearchControllerDelegate {
    
    var presenter: HomePresenterProtocol?
    var searchViewController = SearchViewController()
    
    var timer = Timer()
    var currentPage = 0
    
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSearchController()
    }
    
    func configureSearchController() {
        let searchController = UISearchController(searchResultsController: searchViewController)
        searchController.searchBar.placeholder = "Search"
        searchController.delegate = self
        searchController.searchResultsUpdater = searchViewController
        searchController.searchBar.delegate = searchViewController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor.white
        definesPresentationContext = true
    }
    
    private func autoSlideForTopCollectionView() {
        pageControl.numberOfPages = presenter?.numberOfItemsForNowPlayingMovies ?? 0
        pageControl.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        if currentPage < presenter?.numberOfItemsForNowPlayingMovies ?? 0 {
             let index = IndexPath.init(item: currentPage, section: 0)
             self.topCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pageControl.currentPage = currentPage
             currentPage += 1
        } else {
             currentPage = 0
             let index = IndexPath.init(item: currentPage, section: 0)
             self.topCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
              pageControl.currentPage = currentPage
              currentPage = 1
          }
    }

}

extension HomeViewController: HomeViewControllerProtocol {

    func reloadDataForTopCollectionView() {
        topCollectionView.reloadData()
        autoSlideForTopCollectionView()
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
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bottomCollectionView {
            return CGSize(width: UIScreen.main.bounds.width - 20, height: 105)
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
