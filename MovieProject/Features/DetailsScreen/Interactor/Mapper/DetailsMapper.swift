//
//  DetailsMapper.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class DetailsMapper {
    
    private let posterEndpoint = "https://image.tmdb.org/t/p/w500"
    private let backdropEndpoint = "https://image.tmdb.org/t/p/w700"
    
    func map(from response: MovieDto) -> MovieDetails {
        
        var posterUrl: URL?
        var backdropUrl: URL?
        
        if let posterPath = response.posterPath {
            posterUrl = URL(string: posterEndpoint + posterPath)
        }
        if let backdropPath = response.backdropPath {
            backdropUrl = URL(string: backdropEndpoint + backdropPath)
        }
        
        return MovieDetails(title: response.title,
                            posterUrl: posterUrl,
                            backdropUrl: backdropUrl)
    }
}
