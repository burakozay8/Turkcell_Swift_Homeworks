//
//  OnboardingCell.swift
//  BusSeatApp
//
//  Created by Burak Ozay on 23.02.2022.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    
    func configure(slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
    
}
