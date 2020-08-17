//
//  UIImageView+Extensions.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 07.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

extension UIImageView {
    
    @discardableResult func setImage(from url: URL?) -> URLSessionDataTask? {
        
        guard let url = url else {
            return nil
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, error  in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
        
        dataTask.resume()
        return dataTask
    }
}
