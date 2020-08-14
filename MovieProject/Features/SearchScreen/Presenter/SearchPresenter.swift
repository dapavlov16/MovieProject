//
//  SearchPresenter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

protocol SearchPresenterInput {
    
}

final class SearchPresenter {
    
    //MARK: - Properties
    
    weak var view: SearchViewControllerInput?
}

//MARK: - SearchPresenterInput
extension SearchPresenter: SearchPresenterInput {
    
}
