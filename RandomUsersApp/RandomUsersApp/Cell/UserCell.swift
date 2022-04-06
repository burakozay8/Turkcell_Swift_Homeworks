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
    }

    func configure(user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
    
}
