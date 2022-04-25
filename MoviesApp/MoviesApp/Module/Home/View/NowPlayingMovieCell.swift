//
//  NowPlayingMovieCell.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import UIKit
import Kingfisher

protocol NowPlayingMovieCellProtocol: AnyObject {
    func setImageView(_ imageURL: String)
    func setTitleLabel(_ text: String)
}

final class NowPlayingMovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    var cellPresenter: NowPlayingMovieCellPresenterProtocol? {
        didSet {
            cellPresenter?.load()
        }
    }
    
    private func prepareBackDropImage(with urlString: String) {
        let fullPath = "https://image.tmdb.org/t/p/w500\(urlString)"
        
        if let url = URL(string: fullPath) {
            movieImageView.kf.indicatorType = .activity
            movieImageView.kf.setImage(with: url)
        }
    }
    
}

extension NowPlayingMovieCell: NowPlayingMovieCellProtocol {

    func setImageView(_ imageURL: String) {
//        let url = URL(string: imageURL)
//
//        movieImageView.kf.indicatorType = .activity
//        movieImageView.kf.setImage(with: url) { result in
//            switch result {
//            case .success(let value):
//                break
//            case .failure(_):
//                self.movieImageView.image = UIImage(systemName: "star")
//            }
//        }
        prepareBackDropImage(with: imageURL)
    }
    
    func setTitleLabel(_ text: String) {
        movieTitleLabel.text = text
    }
    
}
