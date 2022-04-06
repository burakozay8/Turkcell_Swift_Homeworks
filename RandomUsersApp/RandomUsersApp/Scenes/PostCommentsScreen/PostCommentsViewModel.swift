//
//  PostCommentsViewModel.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 6.04.2022.
//

import Foundation

protocol PostCommentsViewModelProtocol {
    var delegate: PostCommentsViewModelDelegate? { get set }
    func load()
    var numberOfItems: Int { get }
    func postComment(at index: Int) -> PostComment?
}

protocol PostCommentsViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class PostCommentsViewModel {
    
    private var postComments: [PostComment] = []
    weak var delegate: PostCommentsViewModelDelegate?
    private var service: UserServiceProtocol?
    private var postID: Int?
    
    init(postID: Int, service: UserServiceProtocol = UserService()) {
        self.postID = postID
        self.service = service
    }

    fileprivate func fetchUserComments() {
        delegate?.showLoadingView()
        service?.getUserComments(postID: postID, completion: { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch result {
            case .success(let postComments):
                self.postComments = postComments
                self.delegate?.reloadData()
            case .failure(let errror):
                print(errror.localizedDescription)
            }
        })
    }
    
}

extension PostCommentsViewModel: PostCommentsViewModelProtocol {

    func load() {
        fetchUserComments()
    }
    
    var numberOfItems: Int {
        postComments.count
    }
    
    func postComment(at index: Int) -> PostComment? {
        postComments[safe: index]
    }
    
}
