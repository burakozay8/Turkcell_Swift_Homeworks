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
    
    private func prepareImage(with urlString: String) {
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
    
}

extension UpcomingMoviesCell: UpcomingMoviesCellProtocol {
    
    func setImage(_ imageURL: String) {
        prepareImage(with: imageURL)
    }
    
    func setTitleLabel(_ text: String) {
        movieTitleLabel.text = text
    }
    
    func setOverviewLabel(_ text: String) {
        movieOverviewLabel.text = text
    }
    
    func setReleaseDateLabel(_ text: String) {
        formatDate(with: text)
    }
    
    
}
