//
//  TrendingCellModel.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

struct TrendingCellModel {
    let id: Int
    let title: String
    let posterPath: URL?
    var isFavorite: Bool
}
