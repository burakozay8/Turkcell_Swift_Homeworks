//
//  SimilarMovieCell.swift
//  MoviesApp
//
//  Created by Burak Ozay on 26.04.2022.
//

import UIKit
import Kingfisher

protocol SimilarMovieCellProtocol {
    func setImageView(_ imageURL: String)
    func setTitleLabel(_ text: String)
}

final class SimilarMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var similarMovieImageView: UIImageView!
    @IBOutlet weak var similarMovieTitleLabel: UILabel!
    
    var cellPresenter: SimilarMovieCellPresenterProtocol? {
        didSet {
            cellPresenter?.load()
        }
    }
    
    private func preparePosterImage(with urlString: String) {
        let fullPath = "https://image.tmdb.org/t/p/w200\(urlString)"
        
        if let url = URL(string: fullPath) {
            similarMovieImageView.kf.indicatorType = .activity
            similarMovieImageView.kf.setImage(with: url)
        }
    }
    
}

extension SimilarMovieCell: SimilarMovieCellProtocol {
    
    func setImageView(_ imageURL: String) {
        preparePosterImage(with: imageURL)
    }
    
    func setTitleLabel(_ text: String) {
        similarMovieTitleLabel.text = text
    }
    
}
