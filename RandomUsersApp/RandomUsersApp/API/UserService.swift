//
//  UserService.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 3.04.2022.
//

import Foundation
import Alamofire

protocol UserServiceProtocol {
    func getUserList(completion: @escaping (Result<[User], Error>) -> Void)
    func getUserPosts(userID: Int?, completion: @escaping (Result<[UserPost], Error>) -> Void)
    func getUserComments(postID: Int?, completion: @escaping (Result<[PostComment], Error>) -> Void)
}

class UserService: UserServiceProtocol {

    func getUserList(completion: @escaping (Result<[User], Error>) -> Void) {
        
        let urlString = "https://jsonplaceholder.typicode.com/users"
        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
                let decoder = Decoders.dateDecoder
                do {
                    let users = try decoder.decode([User].self, from: data)
                    completion(.success(users))
                } catch {
                    print("***** JSON DECODING ERROR *****")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getUserPosts(userID: Int?, completion: @escaping (Result<[UserPost], Error>) -> Void) {
        
        let urlString = "https://jsonplaceholder.typicode.com/posts?userId=\(userID ?? 1)"
        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
                let decoder = Decoders.dateDecoder
                do {
                    let userPosts = try decoder.decode([UserPost].self, from: data)
                    completion(.success(userPosts))
                } catch {
                    print("***** JSON DECODING ERROR *****")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getUserComments(postID: Int?, completion: @escaping (Result<[PostComment], Error>) -> Void) {
        
        let urlString = "https://jsonplaceholder.typicode.com/posts/\(postID ?? 1)/comments"
        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
                let decoder = Decoders.dateDecoder
                do {
                    let postComments = try decoder.decode([PostComment].self, from: data)
                    completion(.success(postComments))
                } catch {
                    print("***** JSON DECODING ERROR *****")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}


