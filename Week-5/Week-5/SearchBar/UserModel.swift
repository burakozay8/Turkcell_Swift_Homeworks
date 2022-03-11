//
//  UserModel.swift
//  Week-5
//
//  Created by Burak Ozay on 8.02.2022.
//

import Foundation

struct User: Decodable {
    let username: String
    let email: String
    let company: Company
}

struct Company: Decodable {
    let name: String
}
