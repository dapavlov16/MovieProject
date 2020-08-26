//
//  FavoritesRouter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 21.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol FavoritesRouterInput {
    func navigateToDetails(of id: Int)
}

final class FavoritesRouter {
    
    //MARK: - Properties
    
    weak var view: FavoritesViewController?
}

//MARK: - FavoritesRouterInput
extension FavoritesRouter: FavoritesRouterInput {
    
    func navigateToDetails(of id: Int) {
        view?.navigationController?.pushViewController(DetailsAssembly.assembly(movieId: id),
                                                       animated: true)
    }
}
