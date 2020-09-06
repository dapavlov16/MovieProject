//
//  Request.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 06.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

enum TMDBRequest {
    case searchMovie(text: String, page: Int)
    case getTrending(page: Int)
    case getPopular(page: Int)
    case getDetails(id: Int)
    case getGenres
}

extension TMDBRequest {
    
    private var defaultQueryParams: [String: String] {
        return [
            "api_key": "ff1ba0985dd64688cfcd551134d9d49f",
            "language": "ru-RU"
        ]
    }
    
    private var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        case .getTrending:
            return "/trending/movie/day"
        case .getPopular:
            return "/movie/popular"
        case .getDetails(let id):
            return "/movie/\(id)"
        case .getGenres:
            return "/genre/movie/list"
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
        case .searchMovie(let text, let page):
            params["query"] = text
            params["page"] = String(page)
            return params
        case .getTrending(let page),
             .getPopular(let page):
            params["page"] = String(page)
            return params
        case .getDetails:
            return params
        case .getGenres:
            return params
        }
    }
    
    var urlString: String {
        return baseUrl + path
    }
}
