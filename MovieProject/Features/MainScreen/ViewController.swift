//
//  ViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 02.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        let service = NetworkService()
        service.searchMovie("Snatch") { [weak self] (response) in
            guard let results = response.results else {
                return
            }
            DispatchQueue.main.async {
                self?.label.text = results[0].overview ?? "error"
            }
        }
    }
    
    private func setupView() {
        label = UILabel()
        view.addSubview(label)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

}

