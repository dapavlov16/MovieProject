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
    func removeFavorite(by id: Int)
}

final class FavoritesInteractor {
    
    //MARK: - Properties
    
    var presenter: FavoritesPresenterInput?
    
    private let coreDataService: CoreDataServiceInput
    private let mapper: FavoritesMapper
    
    //MARK: - Init
    
    init(coreDataService: CoreDataServiceInput, mapper: FavoritesMapper) {
        self.coreDataService = coreDataService
        self.mapper = mapper
    }
}

//MARK: - FavoritesInteractorInput
extension FavoritesInteractor: FavoritesInteractorInput {
    
    func loadFavorites() {
        let favorites = mapper.map(from: coreDataService.getFavorites())
        presenter?.favoritesLoaded(favorites: favorites)
    }
    
    func removeFavorite(by id: Int) {
        coreDataService.deleteFavorite(with: id)
    }
}
