//
//  FavoritesInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 21.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol FavoritesInteractorInput {
    func loadFavorites()
}

final class FavoritesInteractor {
    
    //MARK: - Properties
    
    var presenter: FavoritesPresenterInput?
    
    private let coreDataService: CoreDataService
    
    //MARK: - Init
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
}

//MARK: - FavoritesInteractorInput
extension FavoritesInteractor: FavoritesInteractorInput {
    func loadFavorites() {
        
    }
}
