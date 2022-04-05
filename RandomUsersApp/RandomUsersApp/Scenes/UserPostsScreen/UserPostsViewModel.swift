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
}

protocol UserPostsViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class UserPostsViewModel {
    
    weak var delegate: UserPostsViewModelDelegate?
    private var userPosts: [UserPost] = []
    private var service: UserServiceProtocol?
    private var userID: Int?
    
    init(userID: Int, service: UserServiceProtocol = UserService()) {
        self.userID = userID
        self.service = service
    }
    
    fileprivate func fetchUserPosts() {
        self.delegate?.showLoadingView()
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
