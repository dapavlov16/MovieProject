//
//  FavoriteMovie.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 24.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

struct FavoriteMovie {
    let id: Int
    let title: String
    let originalTitle: String
    let releaseDate: Date?
    let genres: [Genre]
    let posterPath: URL?
}
