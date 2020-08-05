//
//  MovieMapper.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

final class MovieMapper {
    
    func map(from response: TMDBResponse) -> [Movie] {
        
        guard let results = response.results else {
            return []
        }
        
        var movies = [Movie]()
        
        for result in results {
            if let id = result.id,
                let title = result.title,
                let originalTitle = result.originalTitle,
                let originalLanguage = result.originalLanguage,
                let overview = result.overview,
                let genres = result.genreIds,
                let releaseDate = result.releaseDate,
                let posterPath = result.posterPath,
                let isAdult = result.adult,
                let backdropPath = result.backdropPath,
                let popularity = result.popularity,
                let voteCount = result.voteCount,
                let voteAverage = result.voteAverage {
                
                movies.append(Movie(id: id,
                                    title: title,
                                    originalTitle: originalTitle,
                                    originalLanguage: originalLanguage,
                                    overview: overview,
                                    genres: genres,
                                    releaseDate: releaseDate,
                                    posterPath: posterPath,
                                    isAdult: isAdult,
                                    backdropPath: backdropPath,
                                    popularity: popularity,
                                    voteCount: voteCount,
                                    voteAverage: voteAverage))
            }
        }
        
        return movies
    }
}
