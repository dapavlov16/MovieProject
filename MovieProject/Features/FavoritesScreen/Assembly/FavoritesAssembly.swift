//
//  FavoritesAssembly.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 21.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

final class FavoritesAssembly {
    
    static func assembly() -> UIViewController {
        let view = FavoritesViewController()
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
