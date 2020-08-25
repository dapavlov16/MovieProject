//
//  Movie.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class Movie {
    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let genres: [Int]
    let releaseDate: Date?
    let posterPath: URL?
    let backdropPath: URL?
    let voteCount: Int
    let voteAverage: Double
    var isFavorite: Bool
    
    init(id: Int,
         title: String,
         originalTitle: String,
         originalLanguage: String,
         overview: String,
         genres: [Int],
         releaseDate: Date?,
         posterPath: URL?,
         backdropPath: URL?,
         voteCount: Int,
         voteAverage: Double,
         isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.genres = genres
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.isFavorite = isFavorite
    }
}
