//
//  FavoritesViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 21.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol FavoritesViewControllerInput: AnyObject {
    
}

final class FavoritesViewController: UIViewController {
    
    var interactor: FavoritesInteractorInput?
    var router: FavoritesRouterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavoritesViewController: FavoritesViewControllerInput {
    
}
