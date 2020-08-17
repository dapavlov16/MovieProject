//
//  DetailsPresenter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol DetailsPresenterInput {
    func detailsLoaded(details: MovieDetails)
}

final class DetailsPresenter {
    
    //MARK: - Properties
    
    weak var view: DetailsViewControllerInput?
    private let formatter: DetailsFormatter
    
    //MARK: - Init
    
    init(formatter: DetailsFormatter) {
        self.formatter = formatter
    }
}

//MARK: - DetailsPresenterInput
extension DetailsPresenter: DetailsPresenterInput {
    func detailsLoaded(details: MovieDetails) {
        let model = formatter.format(from: details)
        DispatchQueue.main.async {
            self.view?.showDetails(model: model)
        }
    }
}
