//
//  GenresMapper.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 17.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class GenresMapper {
    
    func map(from entity: GenresListEntity) -> [Genre] {
        
        guard let genresList = entity.genres else {
            return []
        }
        var genres = [Genre]()
        for genre in genresList {
            if let genre = genre as? GenreEntity, let name = genre.name {
                let id = Int(genre.id)
                genres.append(Genre(id: id, name: name))
            }
        }
        return genres
    }
}
