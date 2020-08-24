//
//  FavoritesFormatter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 24.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class FavoritesFormatter {
    
    func format(movies: [FavoriteMovie]) -> [FavoritesCellModel] {
        movies.map { (movie) -> FavoritesCellModel in
            let genres = movie.genres.map { $0.name }.joined(separator: ", ")
            
            return FavoritesCellModel(id: movie.id,
                                      title: movie.title,
                                      genres: genres, posterURL: movie.posterPath)
        }
    }
}
