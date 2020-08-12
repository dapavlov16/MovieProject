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
}

//MARK: - DetailsPresenterInput
extension DetailsPresenter: DetailsPresenterInput {
    func detailsLoaded(details: MovieDetails) {
        DispatchQueue.main.async {
            self.view?.showDetails(details: details)
        }
    }
}
