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
        presenter?.viewDidLoad()
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
    
    @IBAction func addFavorites(_ sender: Any) {
        presenter?.addFavoritesButtonTapped()
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
            self.prepareImage(with: movieDetail?.backdropPath ?? "")
            self.movieTitleLabel.text = movieDetail?.title
            self.movieOverviewLabel.text = movieDetail?.overview
            guard let voteAverage = movieDetail?.voteAverage else { return }
            self.movieRatingLabel.text = "\(String(describing: voteAverage))"
            self.movieReleaseDateLabel.text = movieDetail?.releaseDate
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
