//
//  UserListViewController.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 3.04.2022.
//

import UIKit

final class UserListViewController: UIViewController, LoadingShowable {

    @IBOutlet weak var userListCollectionView: UICollectionView!
    
    private var viewModel: UserListViewModelProtocol = UserListViewModel() //dene

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        userListCollectionView.register(cellType: UserCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }
    
}

extension UserListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = userListCollectionView.dequeCell(cellType: UserCell.self, indexPath: indexPath)
        if let user = viewModel.user(at: indexPath.row) {
            cell.configure(user: user)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let userID = viewModel.user(at: indexPath.row)?.id else { return }
        let userPostsViewModel = UserPostsViewModel(userID: userID)
        
        guard let userPostsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserPostsViewController") as? UserPostsViewController else { return }
        userPostsVC.set(viewModel: userPostsViewModel)
        navigationController?.pushViewController(userPostsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 60, height: 80) //baska cihazda calıstır.
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
    }
    
}

extension UserListViewController: UserListViewModelDelegate {
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        userListCollectionView.reloadData()
    }
    
}

