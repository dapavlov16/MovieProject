//
//  MovieMapper.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class MovieMapper {
    
    private let imageEndpoint = "https://image.tmdb.org/t/p/w500"
    
    func map(from response: MovieListDto) -> [Movie] {
        var movies = [Movie]()
        
        for result in response.results {
//            guard let id = result.id,
//                let title = result.title,
//                let originalTitle = result.originalTitle,
//                let originalLanguage = result.originalLanguage,
//                let overview = result.overview,
//                let genres = result.genreIds,
//                let releaseDate = result.releaseDate,
//                let isAdult = result.adult,
//                let popularity = result.popularity,
//                let voteCount = result.voteCount,
//                let voteAverage = result.voteAverage
//                else { continue }
//
            var posterURL: URL?
            var backdropURL: URL?
            
            if let posterPath = result.posterPath {
                posterURL = URL(string: imageEndpoint + posterPath)
            }
            if let backdropPath = result.backdropPath {
                backdropURL = URL(string: imageEndpoint + backdropPath)
            }
            
            movies.append(Movie(id: result.id,
                                title: result.title,
                                originalTitle: result.originalTitle,
                                originalLanguage: result.originalLanguage,
                                overview: result.overview,
                                genres: result.genreIds,
                                releaseDate: result.releaseDate,
                                posterPath: posterURL,
                                isAdult: result.adult,
                                backdropPath: backdropURL,
                                popularity: result.popularity,
                                voteCount: result.voteCount,
                                voteAverage: result.voteAverage))
        }
        
        return movies
    }
}
