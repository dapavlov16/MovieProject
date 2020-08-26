//
//  FavoritesPresenter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 21.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol FavoritesPresenterInput {
    func favoritesLoaded(favorites: [FavoriteMovie])
}

final class FavoritesPresenter {
    
    //MARK: - Properties
    
    weak var view: FavoritesViewControllerInput?
    
    private let formatter: FavoritesFormatter
    
    //MARK: - Init
    
    init(formatter: FavoritesFormatter) {
        self.formatter = formatter
    }
}

//MARK: - FavoritesPresenterInput
extension FavoritesPresenter: FavoritesPresenterInput {
    
    func favoritesLoaded(favorites: [FavoriteMovie]) {
        let models = formatter.format(movies: favorites)
        view?.showFavorites(models: models)
    }
}
