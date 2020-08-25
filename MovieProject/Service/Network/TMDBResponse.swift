//
//  TMDBResponse.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 06.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

struct MovieListDto: Decodable {
    var page: Int
    var results: [Result]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Result: Decodable {
    var posterPath: String?
    var adult: Bool
    var overview: String
    var releaseDate: String?
    var genreIds: [Int]
    var id: Int
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var voteCount: Int
    var voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}

struct MovieDto: Decodable {
    var adult: Bool
    var backdropPath: String?
    var budget: Int
    var genres: [Genre]
    var homepage: String?
    var id: Int
    var imdb_id: String?
    var originalLanguage: String
    var originalTitle: String
    var overview: String?
    var posterPath: String?
    var productionCountries: [ProductionCountry]
    var releaseDate: String?
    var revenue: Int
    var runtime: Int
    var status: String
    var tagline: String?
    var title: String
    var voteAverage: Double
    var voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case imdb_id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case status
        case tagline
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct GenresListDto: Decodable {
    var genres: [Genre]
}

struct Genre: Decodable {
    var id: Int
    var name: String
}

struct ProductionCountry: Decodable {
    var iso: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case iso = "iso_3166_1"
        case name
    }
}
