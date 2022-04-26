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
    func getMovie() -> MovieResult?
    func reloadData()
    func setupCollectionView()
    func setfavButtonImage(_ systemName: String, isAdded: Bool)
//    func showMovieDetail(_ movieDetail: MovieDetailResponse?)
}

final class DetailViewController: UIViewController, LoadingShowable {

    @IBOutlet weak var movieDetailImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var presenter: DetailPresenterProtocol?
    
    var movie: MovieResult?
//    var similarMovie: MovieResult? //??
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        showMovieDetail()

    }
    
    private func showMovieDetail() { // dogru mu??
        prepareImage(with: movie?.backdropPath ?? "")
        movieTitleLabel.text = movie?.title
        movieOverviewLabel.text = movie?.overview
        guard let voteAverage = movie?.voteAverage else { return }
        movieRatingLabel.text = "\(String(describing: voteAverage))"
        movieReleaseDateLabel.text = movie?.releaseDate
    }
    
    private func prepareImage(with urlString: String) {
        let fullPath = "https://image.tmdb.org/t/p/w500\(urlString)"
        
        if let url = URL(string: fullPath) {
            movieDetailImageView.kf.indicatorType = .activity
            movieDetailImageView.kf.setImage(with: url)
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
    
    func getMovie() -> MovieResult? {
        return movie
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: SimilarMovieCell.self)
    }
    
    func setfavButtonImage(_ systemName: String, isAdded: Bool) {
        favButton.setImage(UIImage(systemName: systemName), for: UIControl.State.normal)
    }
    
//    func showMovieDetail(_ movieDetail: MovieDetailResponse?) {
//        prepareImage(with: movieDetail?.backdropPath ?? "")
//        movieTitleLabel.text = movieDetail?.title
//        movieOverviewLabel.text = movieDetail?.overview
//        guard let voteAverage = movieDetail?.voteAverage else { return }
//        movieRatingLabel.text = "\(String(describing: voteAverage))"
//        movieReleaseDateLabel.text = movieDetail?.releaseDate
//    }
    
}

extension DetailViewController: DetailPresenterDelegate {
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
