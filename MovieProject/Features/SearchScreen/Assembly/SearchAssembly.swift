//
//  SearchAssembly.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

final class SearchAssembly {
    
    static func assembly() -> UIViewController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        let movieMapper = MovieMapper()
        let genresMapper = GenresMapper()
        let searchFormatter = SearchFormatter()
        
        let view = SearchViewController()
        let presenter = SearchPresenter(formatter: searchFormatter)
        let interactor = SearchInteractor(networkService: networkService,
                                          coreDataService: coreDataService,
                                          movieMapper: movieMapper,
                                          genresMapper: genresMapper)
        let router = SearchRouter()
        
        view.interactor = interactor
        view.router = router
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
