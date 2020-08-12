//
//  DetailsInteractor.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

protocol DetailsInteractorInput {
    
}

final class DetailsInteractor {
    
    //MARK: - Properties
    
    var presenter: DetailsPresenterInput?
}

//MARK: - DetailsInteractorInput
extension DetailsInteractor: DetailsInteractorInput {
    
}
