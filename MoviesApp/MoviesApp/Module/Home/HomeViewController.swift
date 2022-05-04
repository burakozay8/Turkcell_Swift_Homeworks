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
    func setupTableView()
    func reloadDataForTableView()
}

final class HomeViewController: UIViewController, LoadingShowable {
    
    var presenter: HomePresenterProtocol?
    
    private var timer = Timer()
    private var currentPage = 0
    private var customGray = UIColor(rgb: 0x373737)
    private var noResultsView: NoResultsView!
    
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var homeStackView: UIStackView!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityIdentifiers()
        presenter?.viewDidLoad()
        searchTableView.isHidden = true
        searchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        configureNavigationIcon()
        configureNavigationBarAndItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSearchBar()
    }
    
    private func configureNavigationIcon() {
        let image: UIImage = UIImage(named: "popcorn-48.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    private func configureNavigationBarAndItem() {
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func configureSearchBar() {
        searchBar.searchTextField.backgroundColor = customGray
        searchBar.searchTextField.leftView?.tintColor = .systemGray4
        searchBar.searchTextField.textColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray4])
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
    
    func setupTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(cellType: SearchCell.self)
    }
    
    func reloadDataForTableView() {
        searchTableView.reloadData()
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
            return CGSize(width: UIScreen.main.bounds.width - 20, height: 88)
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

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsForSearchedMovies ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(with: SearchCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.accessibilityIdentifier = "searchCell_\(indexPath.row)"
        if let searchMovie = presenter?.searchedMovie(indexPath.row) {
            cell.titleLabel.text = searchMovie.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 50
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAtForSearchedMovies(index: indexPath.row)
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        presenter?.searchMovie(searchText)
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if searchText.count >= 2 {
                if self.presenter?.numberOfRowsForSearchedMovies == 0 {
                    self.homeStackView.isHidden = true
                    self.searchTableView.isHidden = false
                    if self.noResultsView != nil && !self.noResultsView.contentView.isHidden {
                        self.noResultsView?.removeFromSuperview()
                    }
                    self.noResultsView = NoResultsView(frame: CGRect(x: 0, y: 0, width: self.searchTableView.frame.width, height: self.searchTableView.frame.height))
                    self.searchTableView.addSubview(self.noResultsView)
                } else {
                    self.noResultsView?.removeFromSuperview()
                    self.homeStackView.isHidden = true
                    self.searchTableView.isHidden = false
                }
            } else if searchText.isEmpty {
                self.noResultsView?.removeFromSuperview()
                self.homeStackView.isHidden = false
                self.searchTableView.isHidden = true
                searchBar.endEditing(true)
            }

        }

    }

}

extension HomeViewController {
    
    func setAccessibilityIdentifiers() {
        topCollectionView.accessibilityIdentifier = "topCollectionView"
        bottomCollectionView.accessibilityIdentifier = "bottomCollectionView"
        searchBar.accessibilityIdentifier = "searchBar"
        searchTableView.accessibilityIdentifier = "searchTableView"
    }
    
}


