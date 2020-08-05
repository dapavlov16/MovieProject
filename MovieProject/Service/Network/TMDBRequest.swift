//
//  Request.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 06.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

enum TMDBRequest {
    case searchMovie(text: String)
    case getTrending
}

extension TMDBRequest {
    
    private var defaultQueryParams: [String: String] {
        return [
            "api_key": "secret",
            "language": "ru-RU"
        ]
    }
    
    private var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        case .getTrending:
            return "/trending/movie/day"
        }
    }
    
    private var baseUrl: String {
        return "https://api.themoviedb.org/3"
    }
    
    var method: String {
        return "GET"
    }
    
    var queryParams: [String: String] {
        var params = defaultQueryParams
        switch self {
        case .searchMovie(let text):
            params["query"] = text
            return params
        case .getTrending:
            return params
        }
    }
    
    var urlString: String {
        return baseUrl + path
    }
}
