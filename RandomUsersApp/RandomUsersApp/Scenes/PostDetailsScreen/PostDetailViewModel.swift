//
//  PostDetailViewModel.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 5.04.2022.
//

import Foundation

protocol PostDetailViewModelProtocol {
    var delegate: PostDetailViewModelDelegate? { get set }
}

protocol PostDetailViewModelDelegate {
    
}

final class PostDetailViewModel {
    weak var delegate: UserPostsViewModelDelegate?
}
