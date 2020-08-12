//
//  DetailsInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

protocol DetailsInteractorInput {
    func loadDetails()
}

final class DetailsInteractor {
    
    //MARK: - Properties
    
    var presenter: DetailsPresenterInput?
    private let movieId: Int
    private let networkService: NetworkService
    private let mapper: DetailsMapper
    
    //MARK: - Init
    
    init(movieId: Int, networkService: NetworkService, mapper: DetailsMapper) {
        self.movieId = movieId
        self.networkService = networkService
        self.mapper = mapper
    }
}

//MARK: - DetailsInteractorInput
extension DetailsInteractor: DetailsInteractorInput {
    func loadDetails() {
        networkService.getDetails(by: movieId) { response in
            let details = self.mapper.map(from: response)
            self.presenter?.detailsLoaded(details: details)
        }
    }
}
