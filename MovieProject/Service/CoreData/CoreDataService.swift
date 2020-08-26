//
//  CoreDataService.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 17.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataService {
    
    private lazy var managedContext = PersistentContainerProvider.persistentContainer.viewContext
    
    //MARK: - Genres
    
    func getGenresList() -> GenresListEntity? {
        let fetchRequest: NSFetchRequest<GenresListEntity> = GenresListEntity.fetchRequest()
        
        do {
            let genres = try managedContext.fetch(fetchRequest)
            return genres.first
        } catch {
            return nil
        }
    }
    
    func addGenresList(genres: [Genre]) {
        let genresList = GenresListEntity(context: managedContext)
        genresList.count = Int16(genres.count)
        for genre in genres {
            let genreEntity = GenreEntity(context: managedContext)
            genreEntity.id = Int16(genre.id)
            genreEntity.name = genre.name
            genreEntity.list = genresList
        }
        
        saveContext()
    }
    
    //MARK: - Favorites
    
    func getFavorites() -> [FavoriteMovieEntity] {
        let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
        let sortByDate = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortByDate]
        do {
            let movies = try managedContext.fetch(fetchRequest)
            return movies
        } catch {
            return []
        }
    }
    
    func addFavorite(movie: MovieDetails) {
        let favoriteMovie = FavoriteMovieEntity(context: managedContext)
        favoriteMovie.id = Int32(movie.id)
        favoriteMovie.title = movie.title
        favoriteMovie.originalTitle = movie.originalTitle
        favoriteMovie.releaseDate = movie.releaseDate
        favoriteMovie.posterUrl = movie.posterUrl?.absoluteString
        favoriteMovie.date = Date()
        
        for genre in movie.genres {
            let genreEntity = GenreEntity(context: managedContext)
            genreEntity.id = Int16(genre.id)
            genreEntity.name = genre.name
            genreEntity.movie = favoriteMovie
        }
        
        saveContext()
    }
    
    func deleteFavorite(with id: Int) {
        let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        if let result = try? managedContext.fetch(fetchRequest) {
            result.forEach(managedContext.delete(_:))
        }
        
        saveContext()
    }
    
    func isFavorite(movieId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", movieId)
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result.count > 0
        } catch {
            return false
        }
    }
    
    //MARK: - Private
    
    private func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
