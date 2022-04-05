//
//  UserPost.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 3.04.2022.
//

import Foundation

struct UserPost: Decodable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
