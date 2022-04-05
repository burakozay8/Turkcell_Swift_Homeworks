//
//  PostDetailViewModel.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 5.04.2022.
//

import Foundation

protocol PostDetailViewModelProtocol {
    var delegate: PostDetailViewModelDelegate? { get set }
    func load()
}

protocol PostDetailViewModelDelegate {
    func showDetail(userPost: UserPost)
}

final class PostDetailViewModel {
    var delegate: PostDetailViewModelDelegate? //weak var izin vermiyor.
    private var userPost: UserPost
    
    init(userPost: UserPost) {
        self.userPost = userPost
    }
    
}

extension PostDetailViewModel: PostDetailViewModelProtocol {
    
    func load() {
        delegate?.showDetail(userPost: userPost)
    }
    
}
