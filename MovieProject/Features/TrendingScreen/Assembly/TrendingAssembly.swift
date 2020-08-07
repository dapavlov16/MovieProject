//
//  TrendingAssembly.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

final class TrendingAssembly {
    
    static func assembly() -> UIViewController {
        let networkService = NetworkService()
        let movieMapper = MovieMapper()
        let formatter = TrendingCellModelFormatter()
        
        let view = TrendingViewController()
        let presenter = TrendingPresenter(formatter: formatter)
        let interactor = TrendingInteractor(networkService: networkService,
                                            mapper: movieMapper)
        
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
