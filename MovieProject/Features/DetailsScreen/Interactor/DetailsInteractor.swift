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
    func addToFavorite()
    func checkFavoriteState()
}

final class DetailsInteractor {
    
    //MARK: - Properties
    
    var presenter: DetailsPresenterInput?
    private let movieId: Int
    private let networkService: NetworkServiceInput
    private let coreDataService: CoreDataServiceInput
    private let mapper: DetailsMapper
    private var details: MovieDetails!
    
    //MARK: - Init
    
    init(movieId: Int,
         networkService: NetworkServiceInput,
         coreDataService: CoreDataServiceInput,
         mapper: DetailsMapper) {
        self.movieId = movieId
        self.networkService = networkService
        self.coreDataService = coreDataService
        self.mapper = mapper
    }
}

//MARK: - DetailsInteractorInput
extension DetailsInteractor: DetailsInteractorInput {
    func loadDetails() {
        networkService.getDetails(by: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let details = self.mapper.map(from: response)
                self.details = details
                self.presenter?.detailsLoaded(details: details)
            case .failure: break //no-op
            }
        }
    }
    
    func addToFavorite() {
        coreDataService.addFavorite(movie: details)
    }
    
    func checkFavoriteState() {
        presenter?.favoriteState(isFavorite: coreDataService.isFavorite(movieId: movieId))
    }
}
