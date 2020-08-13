//
//  TrendingCellModelFormatter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

final class TrendingCellModelFormatter {
    
    func format(from movies: [Movie]) -> [TrendingCellModel] {
        var models = [TrendingCellModel]()
        
        for movie in movies {
            models.append(TrendingCellModel(title: movie.title,
                                            posterPath: movie.posterPath))
        }
        
        return models
    }
}
