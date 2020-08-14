//
//  SearchViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol SearchViewControllerInput: AnyObject {
    
}

final class SearchViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: SearchInteractorInput?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - SearchViewControllerInput
extension SearchViewController: SearchViewControllerInput {
    
}
