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
        let detailsMapper = DetailsMapper()
        
        let view = DetailsViewController()
        let presenter = DetailsPresenter()
        let interactor = DetailsInteractor(movieId: movieId,
                                           networkService: networkService,
                                           mapper: detailsMapper)
        
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
