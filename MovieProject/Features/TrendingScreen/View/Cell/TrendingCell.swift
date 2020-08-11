//
//  TrendingCell.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

final class TrendingCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var titleLabel: UILabel!
    private var posterImage: UIImageView!
    
    private var dataTask: URLSessionDataTask?
    var viewModel: TrendingCellModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(with: viewModel)
            }
        }
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel()
        posterImage.image = nil
        titleLabel.text = nil
    }
    
    //MARK: - Private
    
    private func configureView() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        addSubview(titleLabel)
        
        posterImage = UIImageView()
        addSubview(posterImage)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImage.heightAnchor.constraint(equalTo: posterImage.widthAnchor,
                                                multiplier: 1.5),
            titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: posterImage.widthAnchor)
        ])
    }
    
    private func updateContent(with viewModel: TrendingCellModel) {
        titleLabel.text = viewModel.title
        dataTask = posterImage.setImage(from: viewModel.posterPath)
    }
}
