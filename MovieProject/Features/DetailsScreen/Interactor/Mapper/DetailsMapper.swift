//
//  DetailsMapper.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class DetailsMapper {
    
    private let imageEndpoint = "https://image.tmdb.org/t/p/w500"
    private lazy var dateFormatter = DateFormatter()
    
    func map(from response: MovieDto) -> MovieDetails {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: response.releaseDate)!
        
        var genres = [String]()
        for genre in response.genres {
            genres.append(genre.name)
        }
        
        var countries = [String]()
        for country in response.productionCountries {
            countries.append(country.name)
        }
        
        var posterUrl: URL?
        var backdropUrl: URL?
        
        if let posterPath = response.posterPath {
            posterUrl = URL(string: imageEndpoint + posterPath)
        }
        if let backdropPath = response.backdropPath {
            backdropUrl = URL(string: imageEndpoint + backdropPath)
        }
        
        return MovieDetails(title: response.title,
                            originalTitle: response.originalTitle,
                            tagline: response.tagline,
                            genres: genres,
                            countries: countries,
                            runtime: response.runtime,
                            overview: response.overview,
                            releaseDate: date,
                            rating: response.voteAverage,
                            voteCount: response.voteCount,
                            posterUrl: posterUrl,
                            backdropUrl: backdropUrl)
    }
}
