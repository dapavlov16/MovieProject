//
//  DetailsAssembly.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

final class DetailsAssembly {
    
    static func assembly(movieId: Int) -> UIViewController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        let detailsMapper = DetailsMapper()
        let detailsFormatter = DetailsFormatter()
        
        let view = DetailsViewController()
        let presenter = DetailsPresenter(formatter: detailsFormatter)
        let interactor = DetailsInteractor(movieId: movieId,
                                           networkService: networkService,
                                           coreDataService: coreDataService,
                                           mapper: detailsMapper)
        
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
