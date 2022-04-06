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
    func postID() -> Int?
}

protocol PostDetailViewModelDelegate: AnyObject {
    func showDetail(userPost: UserPost)
}

final class PostDetailViewModel {
    
    weak var delegate: PostDetailViewModelDelegate?
    private var userPost: UserPost
    
    init(userPost: UserPost) {
        self.userPost = userPost
    }
    
}

extension PostDetailViewModel: PostDetailViewModelProtocol {
    
    func load() {
        delegate?.showDetail(userPost: userPost)
    }
    
    func postID() -> Int? {
        userPost.id
    }
    
}
