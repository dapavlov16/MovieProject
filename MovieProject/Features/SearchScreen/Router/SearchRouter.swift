//
//  SearchRouter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 17.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

protocol SearchRouterInput {
    func navigateToDetails(of id: Int)
}

final class SearchRouter {
    
    //MARK: - Properties
    
    weak var view: SearchViewController?
}

//MARK: - SearchRouterInput
extension SearchRouter: SearchRouterInput {
    func navigateToDetails(of id: Int) {
        view?.navigationController?.pushViewController(DetailsAssembly.assembly(movieId: id),
                                                       animated: true)
    }
}
