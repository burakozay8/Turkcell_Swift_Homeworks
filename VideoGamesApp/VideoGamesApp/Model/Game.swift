//
//  Game.swift
//  VideoGamesApp
//
//  Created by Burak Ozay on 5.03.2022.
//

import Foundation


struct Game: Decodable {
    let results: [GameResult]
}

struct GameResult: Decodable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let background_image: String
    let rating: Double
}



