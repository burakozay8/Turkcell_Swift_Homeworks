//
//  UserListViewModel.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 3.04.2022.
//

import Foundation

protocol UserListViewModelProtocol {
    var delegate: UserListViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    func load()
    func user(at index: Int) -> User?
}

protocol UserListViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class UserListViewModel {
    
    private var users: [User] = []
    weak var delegate: UserListViewModelDelegate?
    var service: UserServiceProtocol = UserService()
    
    fileprivate func fetchUsers() {
        
        self.delegate?.showLoadingView()
        service.getUserList { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch result {
            case .success(let users):
                self.users = users
                self.delegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

extension UserListViewModel: UserListViewModelProtocol {
    
    var numberOfItems: Int {
        users.count
    }
    
    func load() {
        fetchUsers()
    }
    
    func user(at index: Int) -> User? {
        users[safe: index]
    }
    
}

