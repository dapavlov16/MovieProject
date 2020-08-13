//
//  Movie.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

struct Movie {
    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let genres: [Int]
    let releaseDate: String
    let posterPath: String
    let isAdult: Bool
    let backdropPath: String
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
}
