//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Burak Ozay on 25.04.2022.
//

import UIKit
import Kingfisher

protocol DetailViewControllerProtocol: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func setupCollectionView()
    func reloadData()
    func getMovie() -> MovieResult?
    func showMovieDetail(_ movieDetail: MovieDetailResponse?)
    func setfavButtonImage(_ systemName: String, isAdded: Bool)
    func addFavoritesButtonTapped(id: Int)
}

final class DetailViewController: UIViewController, LoadingShowable {

    @IBOutlet private weak var movieDetailImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet private weak var movieRatingLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var presenter: DetailPresenterProtocol?
    var movie: MovieResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accessibilityIdentifiers()
        presenter?.viewDidLoad()
        configureNavigationBarAndItem()
    }
    
    private func prepareImage(with urlString: String) {
        
        let fullPath = "https://image.tmdb.org/t/p/w500\(urlString)"

        if let url = URL(string: fullPath) {
            movieDetailImageView.kf.indicatorType = .activity
            movieDetailImageView.kf.setImage(with: url) { result in
            switch result {
                case .success(_):
                    break
                case .failure(_):
                    self.movieDetailImageView.image = UIImage(named: "no-image-available.png")
                }
            }
        }
        
    }
    
    private func formatDate(with dateString: String) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = "MMM dd, yyyy"

        if let date = dateFormatterGet.date(from: dateString) {
            self.movieReleaseDateLabel.text = dateFormatterSet.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
    }
    
    @IBAction func addFavorites(_ sender: Any) {
        presenter?.addFavoritesButtonTapped()
    }
    
    private func configureNavigationBarAndItem() {
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: SimilarMovieCell.self)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func getMovie() -> MovieResult? {
        return movie
    }
    
    func showMovieDetail(_ movieDetail: MovieDetailResponse?) {
        prepareImage(with: movieDetail?.backdropPath ?? "")
        movieTitleLabel.text = movieDetail?.title
        movieOverviewLabel.text = movieDetail?.overview
        guard let voteAverage = movieDetail?.voteAverage else { return }
        movieRatingLabel.text = "\(String(describing: voteAverage))"
        formatDate(with: movieDetail?.releaseDate ?? "")
    }
    
    func setfavButtonImage(_ systemName: String, isAdded: Bool) {
        favButton.setImage(UIImage(systemName: systemName), for: UIControl.State.normal)
    }
    
    func addFavoritesButtonTapped(id: Int) {
        presenter?.addFavoritesMovie(id: id)
    }
    
}

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItemAt(index: indexPath.row)
    }
    
}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: SimilarMovieCell.self, indexPath: indexPath)
        cell.accessibilityIdentifier = "similarMovieCell_\(indexPath.row)"
        if let similarMovie = presenter?.similarMovie(indexPath.row) {
            cell.cellPresenter = SimilarMovieCellPresenter(view: cell, similarMovie: similarMovie)
        }
        return cell
    }
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 110)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            12
    }

}

extension DetailViewController {
    
    func accessibilityIdentifiers() {
        movieTitleLabel.accessibilityIdentifier = "movieTitleLabel"
        favButton.accessibilityIdentifier = "favButton"
        collectionView.accessibilityIdentifier = "similarMoviesCollectionView"
    }
    
}
