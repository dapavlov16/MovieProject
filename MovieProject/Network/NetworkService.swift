//
//  NetworkService.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 06.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

class NetworkService {
    
    private let client = TMDBClient()
    
    func searchMovie(_ text: String, _ completion: @escaping (TMDBResponse) -> Void) {
        client.request(request: .searchMovie(text: text), completion)
    }
}
