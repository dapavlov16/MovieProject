//
//  PersistentContainerProvider.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 17.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import CoreData

final class PersistentContainerProvider {
    
    // MARK: - Core Data stack

    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
