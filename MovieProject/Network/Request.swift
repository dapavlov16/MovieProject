//
//  Request.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 06.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

enum Request {
    case searchMovie(text: String)
}

extension Request {
    
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
        }
    }
    
    private var baseUrl: String {
        switch self {
        case .searchMovie:
            return "https://api.themoviedb.org/3"
        }
    }
    
    var method: String {
        switch self {
        case .searchMovie:
            return "GET"
        }
    }
    
    var queryParams: [String: String] {
        var params = defaultQueryParams
        switch self {
        case .searchMovie(let text):
            params["query"] = text
            return params
        }
    }
    
    var url: String {
        return baseUrl + path
    }
}
