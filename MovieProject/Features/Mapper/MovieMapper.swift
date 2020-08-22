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
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func map(from response: MovieListDto) -> [Movie] {
        var movies = [Movie]()
        
        for result in response.results {
            var posterURL: URL?
            var backdropURL: URL?
            
            if let posterPath = result.posterPath {
                posterURL = URL(string: imageEndpoint + posterPath)
            }
            if let backdropPath = result.backdropPath {
                backdropURL = URL(string: imageEndpoint + backdropPath)
            }
            
            var date: Date?
            if let release = result.releaseDate {
                date = dateFormatter.date(from: release)
            }
            
            movies.append(Movie(id: result.id,
                                title: result.title,
                                originalTitle: result.originalTitle,
                                originalLanguage: result.originalLanguage,
                                overview: result.overview,
                                genres: result.genreIds,
                                releaseDate: date,
                                posterPath: posterURL,
                                backdropPath: backdropURL,
                                popularity: result.popularity,
                                voteCount: result.voteCount,
                                voteAverage: result.voteAverage))
        }
        
        return movies
    }
}
