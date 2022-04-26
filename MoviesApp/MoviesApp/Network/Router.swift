//
//  Router.swift
//  MoviesApp
//
//  Created by Burak Ozay on 24.04.2022.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let apiKey = "f51acbdf42a93716d3349a04da162c57"
    
    case nowPlaying
    case upcoming
    case search(query: String?)
    case detail(movieID: Int?)
    case similar(movieID: Int?)
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .nowPlaying, .upcoming, .search, .detail, .similar:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        var params: Parameters = [:]
        switch self {
        case .nowPlaying:
            return nil //?
        case .upcoming:
            return nil //?
        case .search(query: let query):
        if let query = query {
            params["query"] = query
            }
        case .detail:
            return nil
        case.similar:
            return nil
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .upcoming:
            return "/movie/upcoming"
        case.search:
            return "/search/movie"
        case .detail(movieID: let movieID):
            guard let movieID = movieID else { return "" }
            return "/movie/\(String(describing: movieID))"
        case.similar(movieID: let movieID):
            guard let movieID = movieID else { return "" }
            return "/movie/\(String(describing: movieID))/similar"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        
        completeParameters["api_key"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        debugPrint("************> MY URL: ", urlRequestPrint.url ?? "")
        
        return try encoding.encode(urlRequest, with: completeParameters)
    }
    
}
