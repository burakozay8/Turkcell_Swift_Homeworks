//
//  GameRequest.swift
//  VideoGamesApp
//
//  Created by Burak Ozay on 5.03.2022.
//

import Foundation

enum GameError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct GameRequest {
    
    let resourceURL: URL
    let detailResourceURL: URL
    
    init() {
        
        let resourceString = "https://api.rawg.io/api/games?key=0f20f8bec1b34e06b85ba0e8ed9616ec"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("Error")
        }
        
        self.resourceURL = resourceURL
        self.detailResourceURL = resourceURL //useless
    }
    
    init(slug: String) {
        
        let detailResourceString = "https://api.rawg.io/api/games/\(slug)?key=0f20f8bec1b34e06b85ba0e8ed9616ec"
        guard let detailResourceURL = URL(string: detailResourceString) else {
            fatalError("Error")
        }
        self.detailResourceURL = detailResourceURL
        self.resourceURL = detailResourceURL //useless
    }
    
    
    public func getGame(completion: @escaping(Result<[GameResult], GameError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let game = try decoder.decode(Game.self, from: jsonData)
                completion(.success(game.results))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    public func getGameDetails(completion: @escaping(Result<GameDetail, GameError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: detailResourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let gameDetail = try decoder.decode(GameDetail.self, from: jsonData)
                completion(.success(gameDetail))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}



