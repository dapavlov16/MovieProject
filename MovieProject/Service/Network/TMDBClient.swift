//
//  TMDBClient.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 06.07.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import Foundation

final class TMDBClient {
    
    @discardableResult func request<T: Decodable>(request: TMDBRequest, _ completion: @escaping (T) -> Void) -> URLSessionDataTask? {
        var urlBuilder = URLComponents(string: request.urlString)
        urlBuilder?.queryItems = request.queryParams.map { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        
        if let url = urlBuilder?.url {
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, response != nil , error == nil else {
                    return
                }
                do {
                    completion(try JSONDecoder().decode(T.self, from: data))
                } catch {
                    print(error)
                }
            }
            dataTask.resume()
            return dataTask
        }
        return nil
    }
}
