//
//  TrendingRouter.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

protocol TrendingRouterInput {
    func navigateToDetails(of id: Int)
}

final class TrendingRouter {
    
    //MARK: - Properties
    
    weak var view: TrendingViewController?
}

//MARK: - TrendingRouterInput
extension TrendingRouter: TrendingRouterInput {
    func navigateToDetails(of id: Int) {
        view?.navigationController?.pushViewController(DetailsAssembly.assembly(movieId: id),
                                                       animated: true)
    }
}
