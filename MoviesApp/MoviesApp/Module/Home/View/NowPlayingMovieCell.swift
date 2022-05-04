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
}

final class NowPlayingMovieCell: UICollectionViewCell {

    @IBOutlet private weak var movieImageView: UIImageView!
    
    var cellPresenter: NowPlayingMovieCellPresenterProtocol? {
        didSet {
            cellPresenter?.load()
        }
    }
    
    private func prepareBackDropImage(with urlString: String) {
        
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

extension NowPlayingMovieCell: NowPlayingMovieCellProtocol {

    func setImageView(_ imageURL: String) {
        prepareBackDropImage(with: imageURL)
    }
    
}
