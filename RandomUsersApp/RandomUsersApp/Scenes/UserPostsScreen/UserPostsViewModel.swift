//
//  UserPostsViewModel.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 3.04.2022.
//

import Foundation

protocol UserPostsViewModelProtocol {
    var delegate: UserPostsViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    func load()
    func userPost(at index: Int) -> UserPost?
    func loadUserName()
}

protocol UserPostsViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
    func showUserName(userName: String?)
}

final class UserPostsViewModel {
    
    weak var delegate: UserPostsViewModelDelegate?
    private var userPosts: [UserPost] = []
    private var service: UserServiceProtocol?
    private var userID: Int?
    private var userName: String?
    
    init(userID: Int, userName: String, service: UserServiceProtocol = UserService()) {
        self.userID = userID
        self.service = service
        self.userName = userName
    }
    
    fileprivate func fetchUserPosts() {
        delegate?.showLoadingView()
        service?.getUserPosts(userID: userID) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch result {
            case .success(let userPosts):
                self.userPosts = userPosts
                self.delegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension UserPostsViewModel: UserPostsViewModelProtocol {
    
    func loadUserName() {
        delegate?.showUserName(userName: userName)
    }
    
    var numberOfItems: Int {
        userPosts.count
    }
    
    func load() {
        fetchUserPosts()
    }
    
    func userPost(at index: Int) -> UserPost? {
        userPosts[safe: index]
    }
    
}
