//
//  SearchCellModel.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

struct SearchCellModel {
    let id: Int
    let title: String
    let subtitle: String
    let genres: String?
    let rating: Double
    let posterURL: URL?
}
