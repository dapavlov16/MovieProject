//
//  FavoritesMapper.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 24.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class FavoritesMapper {
    
    func map(from entities: [FavoriteMovieEntity]) -> [FavoriteMovie] {
        var movies = [FavoriteMovie]()
        for entity in entities {
            if let title = entity.title,
                let originalTitle = entity.originalTitle,
                let genreEntities = entity.genres {
                
                let id = Int(entity.id)
                var posterURL: URL?
                if let posterPath = entity.posterUrl {
                    posterURL = URL(string: posterPath)
                }
                let genres = map(genreEntities: genreEntities)
                movies.append(FavoriteMovie(id: id,
                                            title: title,
                                            originalTitle: originalTitle,
                                            releaseDate: entity.releaseDate,
                                            genres: genres,
                                            posterPath: posterURL))
            }
        }
        return movies
    }
    
    private func map(genreEntities: NSSet) -> [Genre] {
        var genres = [Genre]()
        for genreEntity in genreEntities {
            if let genre = genreEntity as? GenreEntity, let name = genre.name {
                let id = Int(genre.id)
                genres.append(Genre(id: id, name: name))
            }
        }
        return genres
    }
}
