//
//  UpcomingMoviesCell.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import UIKit
import Kingfisher

protocol UpcomingMoviesCellProtocol: AnyObject {
    func setImage(_ imageURL: String)
    func setTitleLabel(_ text: String)
    func setOverviewLabel(_ text: String)
    func setReleaseDateLabel(_ text: String)
    
}

final class UpcomingMoviesCell: UICollectionViewCell {
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieOverviewLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    
    var cellPresenter: UpcomingMoviesCellPresenterProtcol? {
        didSet {
            cellPresenter?.load()
        }
    }
    
    private func preparePosterImage(with urlString: String) {
        
        let fullPath = "https://image.tmdb.org/t/p/w500\(urlString)"

        if let url = URL(string: fullPath) {
            movieImageView.kf.indicatorType = .activity
            movieImageView.kf.setImage(with: url) { result in
            switch result {
                case .success(_):
                    break
                case .failure(_):
                    self.movieImageView.image = UIImage(named: "no-image-available.png")
                }
            }
        }
        
    }
    
}

extension UpcomingMoviesCell: UpcomingMoviesCellProtocol {
    
    func setImage(_ imageURL: String) {
        preparePosterImage(with: imageURL)
    }
    
    func setTitleLabel(_ text: String) {
        movieTitleLabel.text = text
    }
    
    func setOverviewLabel(_ text: String) {
        movieOverviewLabel.text = text
    }
    
    func setReleaseDateLabel(_ text: String) {
        movieReleaseDateLabel.text = text
    }
    
    
}
