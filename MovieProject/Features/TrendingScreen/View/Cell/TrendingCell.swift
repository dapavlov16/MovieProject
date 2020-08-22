//
//  TrendingCell.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 05.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

final class TrendingCell: UICollectionViewCell {
    
    //MARK: - Constants
    
    private enum Constants {
        static let titleFont = UIFont.systemFont(ofSize: 14, weight: .thin)
        static let posterCornerRadius: CGFloat = 7
    }
    
    //MARK: - Properties
    
    private var titleLabel: UILabel!
    private var posterImageView: UIImageView!
    
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
        posterImageView.image = nil
        titleLabel.text = nil
    }
    
    //MARK: - Private
    
    private func configureView() {
        titleLabel = UILabel()
        titleLabel.font = Constants.titleFont
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        addSubview(titleLabel)
        
        posterImageView = UIImageView()
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = Constants.posterCornerRadius
        addSubview(posterImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor,
                                                    multiplier: 1.5),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: posterImageView.widthAnchor)
        ])
    }
    
    private func updateContent(with viewModel: TrendingCellModel) {
        titleLabel.text = viewModel.title
        if viewModel.isFavorite {
            titleLabel.textColor = .red
        } else {
            titleLabel.textColor = .black
        }
        posterImageView.image = UIImage(named: "poster_placeholder")
        dataTask = posterImageView.setImage(from: viewModel.posterPath)
    }
}
