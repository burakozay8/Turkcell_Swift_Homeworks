//
//  GameDetail.swift
//  VideoGamesApp
//
//  Created by Burak Ozay on 7.03.2022.
//

import Foundation

struct GameDetail: Decodable {
    var id: Int
    let slug: String
    let name: String
    let released: String
    let background_image: String
    let rating: Double
    let description: String
    let metacritic: Int
}
