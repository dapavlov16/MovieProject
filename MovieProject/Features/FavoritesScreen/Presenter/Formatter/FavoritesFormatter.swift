//
//  FavoritesFormatter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 24.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class FavoritesFormatter {
    
    private lazy var calendar = Calendar.current
    
    func format(movies: [FavoriteMovie]) -> [FavoritesCellModel] {
        movies.map { (movie) -> FavoritesCellModel in
            let genres = movie.genres.map { $0.name }.joined(separator: ", ")
            var originalTitle = movie.originalTitle
            if let releaseDate = movie.releaseDate {
                let year = calendar.component(.year, from: releaseDate)
                originalTitle.append(" (\(year))")
            }
            return FavoritesCellModel(id: movie.id,
                                      title: movie.title,
                                      originalTitle: originalTitle,
                                      genres: genres, posterURL: movie.posterPath)
        }
    }
}
