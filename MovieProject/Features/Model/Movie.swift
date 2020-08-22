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
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
    var isFavorite: Bool = false
    
    init(id: Int,
         title: String,
         originalTitle: String,
         originalLanguage: String,
         overview: String,
         genres: [Int],
         releaseDate: Date?,
         posterPath: URL?,
         backdropPath: URL?,
         popularity: Double,
         voteCount: Int,
         voteAverage: Double) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.genres = genres
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.voteAverage = voteAverage
    }
}
