//
//  SimilarMoviesResponse.swift
//  MoviesApp
//
//  Created by Burak Ozay on 25.04.2022.
//

import Foundation

// MARK: - SimilarMoviesResponse
struct SimilarMoviesResponse: Codable { //sil.
    let page: Int?
    let results: [SimilarMovieResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey, Codable {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarMovieResult: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let title: String?
    let originalLanguage: OriginalLanguages?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey, Codable {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguages: String, Codable {
    case en = "en"
}

