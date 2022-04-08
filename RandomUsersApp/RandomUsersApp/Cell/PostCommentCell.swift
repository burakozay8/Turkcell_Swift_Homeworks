//
//  PostCommentCell.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 6.04.2022.
//

import UIKit

class PostCommentCell: UICollectionViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(postComment: PostComment) {
        emailLabel.text = postComment.email
        commentLabel.text = (postComment.body?.html2String.capitalizingFirstLetter() ?? "") + "."
    }

}
