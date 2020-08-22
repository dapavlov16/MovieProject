//
//  File.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

struct MovieDetails {
    let id: Int
    let title: String
    let originalTitle: String
    let tagline: String?
    let genres: [Genre]
    let countries: [String]
    let runtime: Int
    let overview: String?
    let releaseDate: Date
    let rating: Double
    let voteCount: Int
    let posterUrl: URL?
    let backdropUrl: URL?
}

struct DetailsModel {
    let title: String
    let titleDescription: String
    let tagline: String?
    let genresString: String?
    let countriesRuntimeString: String
    let overview: String?
    let releaseDateString: String
    let posterUrl: URL?
    let backdropUrl: URL?
}
