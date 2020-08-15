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
        let movieMapper = MovieMapper()
        let searchFormatter = SearchFormatter()
        
        let view = SearchViewController()
        let presenter = SearchPresenter(formatter: searchFormatter)
        let interactor = SearchInteractor(networkService: networkService,
                                          mapper: movieMapper)
        
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
