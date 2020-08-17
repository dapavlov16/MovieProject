//
//  SearchFormatter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class SearchFormatter {
    
    func format(movies: [Movie], genresList: [Genre]) -> [SearchCellModel] {
        var models = [SearchCellModel]()
        let calendar = Calendar.current
        
        for movie in movies {
            var subtitle = movie.originalTitle
            if let date = movie.releaseDate {
                let year = calendar.component(.year, from: date)
                subtitle.append(contentsOf: " (\(year))")
            }
            let genres = genresList.filter { movie.genres.contains($0.id) }
                .map{ $0.name }
                .joined(separator: ", ")
            
            models.append(SearchCellModel(id: movie.id,
                                          title: movie.title,
                                          subtitle: subtitle,
                                          genres: genres,
                                          rating: movie.voteAverage,
                                          posterURL: movie.posterPath))
        }
        
        return models
    }
}
