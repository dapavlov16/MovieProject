//
//  CoreDataServiceMock.swift
//  MovieProjectTests
//
//  Created by Дмитрий Павлов on 26.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

@testable import MovieProject

final class CoreDataServiceMock: CoreDataServiceInput {
    
    func getGenresList() -> GenresListEntity? {
        //stub
        return nil
    }
    
    func addGenresList(genres: [Genre]) {
        //stub
    }
    
    func getFavorites() -> [FavoriteMovieEntity] {
        //stub
        return []
    }
    
    func addFavorite(movie: MovieDetails) {
        //stub
    }
    
    func deleteFavorite(with id: Int) {
        //stub
    }
    
    func isFavorite(movieId: Int) -> Bool {
        //stub
        return true
    }
}
