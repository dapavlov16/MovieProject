//
//  DetailsViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol DetailsViewControllerInput: AnyObject {
    
}

final class DetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: DetailsInteractorInput?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

//MARK: - DetailsViewControllerInput
extension DetailsViewController: DetailsViewControllerInput {
    
}
