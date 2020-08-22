//
//  FavoritesPresenter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 21.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol FavoritesPresenterInput {
    
}

final class FavoritesPresenter {
    
    //MARK: - Properties
    
    weak var view: FavoritesViewControllerInput?
}

//MARK: - FavoritesPresenterInput
extension FavoritesPresenter: FavoritesPresenterInput {
    
}
