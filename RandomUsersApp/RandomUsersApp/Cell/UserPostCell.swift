//
//  UserPostCell.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 4.04.2022.
//

import UIKit

class UserPostCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(userPost: UserPost) {
        titleLabel.text = userPost.title?.capitalizingFirstLetter()
    }

}
