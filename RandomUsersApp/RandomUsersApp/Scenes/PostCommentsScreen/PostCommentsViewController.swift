//
//  PostCommentsViewController.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 6.04.2022.
//

import UIKit

class PostCommentsViewController: UIViewController, LoadingShowable {

    @IBOutlet weak var postCommentsCollectionView: UICollectionView!
    private var viewModel: PostCommentsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        postCommentsCollectionView.register(cellType: PostCommentCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.load()
    }
    
    func set(viewModel: PostCommentsViewModelProtocol) {
        self.viewModel = viewModel
    }

}

extension PostCommentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postCommentsCollectionView.dequeCell(cellType: PostCommentCell.self, indexPath: indexPath)
        if let postComment = viewModel?.postComment(at: indexPath.row) {
            cell.configure(postComment: postComment)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 30, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
    }
    
}

extension PostCommentsViewController: PostCommentsViewModelDelegate {
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        postCommentsCollectionView.reloadData()
    }
    
}
