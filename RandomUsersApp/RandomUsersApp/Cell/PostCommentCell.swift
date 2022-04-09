//
//  PostCommentCell.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 6.04.2022.
//

import UIKit

class PostCommentCell: UICollectionViewCell {
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(postComment: PostComment) {
        emailLabel.text = postComment.email
        commentLabel.text = (postComment.body?.html2String.capitalizingFirstLetter() ?? "") + "."
    }

}
