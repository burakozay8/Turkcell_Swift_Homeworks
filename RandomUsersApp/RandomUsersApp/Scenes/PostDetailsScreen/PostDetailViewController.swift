//
//  PostDetailViewController.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 5.04.2022.
//

import UIKit

final class PostDetailViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var readCommentsButton: UIButton!
    
    private var viewModel: PostDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.load()
    }
    
    func set(viewModel: PostDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    private func styleBackItem() {
        let backItem = UIBarButtonItem()
        backItem.title = "Post Detail"
        navigationItem.backBarButtonItem = backItem
    }
    
    @IBAction func readCommentsButtonAction(_ sender: Any) {
        
        guard let postID = viewModel?.postID() else { return }
        let postCommentsViewModel = PostCommentsViewModel(postID: postID)
        
        styleBackItem()
        
        guard let postCommentsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostCommentsViewController") as? PostCommentsViewController else { return }
        postCommentsVC.set(viewModel: postCommentsViewModel)
        navigationController?.pushViewController(postCommentsVC, animated: true)
        
    }
    
}

extension PostDetailViewController: PostDetailViewModelDelegate {
    func showDetail(userPost: UserPost) {
        titleLabel.text = userPost.title?.capitalizingFirstLetter()
        bodyLabel.text = (userPost.body?.html2String.capitalizingFirstLetter() ?? "") + "."
    }
}
