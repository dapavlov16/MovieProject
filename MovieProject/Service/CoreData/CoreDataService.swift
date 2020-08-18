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
