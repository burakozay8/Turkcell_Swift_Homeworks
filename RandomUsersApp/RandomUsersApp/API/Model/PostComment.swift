//
//  UserComment.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 5.04.2022.
//

import Foundation

struct PostComment: Decodable {
    let postID, id: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
