//
//  Movie.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let genres: [Int]
    let releaseDate: Date?
    let posterPath: URL?
    let isAdult: Bool
    let backdropPath: URL?
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
}
