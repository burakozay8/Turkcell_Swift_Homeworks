//
//  UserPostsViewController.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 3.04.2022.
//

import UIKit

final class UserPostsViewController: UIViewController, LoadingShowable {
    
    @IBOutlet weak var userPostsCollectionView: UICollectionView!
    @IBOutlet private weak var headerLabel: UILabel!
    
    private var viewModel: UserPostsViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        userPostsCollectionView.register(cellType: UserPostCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.load()
        viewModel?.loadUserName()
    }
    
    func set(viewModel: UserPostsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    private func styleBackItem() {
        let backItem = UIBarButtonItem()
        backItem.title = "Posts"
        navigationItem.backBarButtonItem = backItem
    }
        
}

extension UserPostsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = userPostsCollectionView.dequeCell(cellType: UserPostCell.self, indexPath: indexPath)
        if let userPost = viewModel?.userPost(at: indexPath.row) {
            cell.configure(userPost: userPost)
        }
        cell.showMoreButton.tag = indexPath.row
        cell.showMoreButton.addTarget(self, action: #selector(viewPostDetail), for: .touchUpInside)
        return cell
    }
    
    @objc func viewPostDetail(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        guard let userPost = viewModel?.userPost(at: indexPath.row) else { return }
        let postDetailViewModel = PostDetailViewModel(userPost: userPost)

        styleBackItem()

        guard let postDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController else { return }
        postDetailVC.set(viewModel: postDetailViewModel)
        navigationController?.pushViewController(postDetailVC, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let userPost = viewModel?.userPost(at: indexPath.row) else { return }
//        let postDetailViewModel = PostDetailViewModel(userPost: userPost)
//
//        styleBackItem()
//
//        guard let postDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController else { return }
//        postDetailVC.set(viewModel: postDetailViewModel)
//        navigationController?.pushViewController(postDetailVC, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 55, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
    }
    
}

extension UserPostsViewController: UserPostsViewModelDelegate {
    
    func showUserName(userName: String?) {
        headerLabel.text = (userName ?? "") + "'s" + " " + "Posts"
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    
    func reloadData() {
        userPostsCollectionView.reloadData()
    }
    
}
