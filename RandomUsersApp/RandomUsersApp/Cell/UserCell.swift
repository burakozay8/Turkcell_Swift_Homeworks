//
//  UserCell.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 3.04.2022.
//

import UIKit

class UserCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        containerView.layer.cornerRadius = 5
//        containerView.layer.shadowColor = UIColor.white.cgColor
//        containerView.layer.shadowOpacity = 1
//        containerView.layer.shadowOffset = CGSize(width: 30, height: 30)
//        containerView.layer.shadowRadius = 10
    }

    func configure(user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
    
}
