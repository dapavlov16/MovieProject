//
//  FavoritesCell.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 21.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    //MARK: - Constants
    
    private enum Constants {
        static let titleFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let originalTitleFont = UIFont.systemFont(ofSize: 14, weight: .thin)
        static let genresFont = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        static let stackViewSpacing: CGFloat = 5
    }
    
    //MARK: - Properties
    
    private var titleLabel: UILabel!
    private var originalTitleLabel: UILabel!
    private var genresLabel: UILabel!
    private var posterImageView: UIImageView!
    
    private var dataTask: URLSessionDataTask?
    var viewModel: FavoritesCellModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(with: viewModel)
            }
        }
    }
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configurePosterImageView()
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dataTask?.cancel()
        posterImageView.image = nil
    }
    
    //MARK: - Private
    
    private func configurePosterImageView() {
        posterImageView = UIImageView()
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor,
                                                   multiplier: 2/3)
        ])
    }
    
    private func configureLabels() {
        titleLabel = UILabel()
        titleLabel.font = Constants.titleFont
        titleLabel.numberOfLines = 0
        
        originalTitleLabel = UILabel()
        originalTitleLabel.font = Constants.originalTitleFont
        originalTitleLabel.numberOfLines = 0
        
        genresLabel = UILabel()
        genresLabel.font = Constants.genresFont
        genresLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       originalTitleLabel,
                                                       genresLabel])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = Constants.stackViewSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,
                                               constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func updateContent(with model: FavoritesCellModel) {
        posterImageView.image = UIImage(named: "poster_placeholder")
        dataTask = posterImageView.setImage(from: model.posterURL)
        titleLabel.text = model.title
        originalTitleLabel.text = model.originalTitle
        genresLabel.text = model.genres
    }
}
