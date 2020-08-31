//
//  SearchCell.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 14.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    //MARK: - Constants
    
    private enum Constants {
        static let titleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let subtitleFont = UIFont.systemFont(ofSize: 14, weight: .light)
        static let genresFont = UIFont.systemFont(ofSize: 12, weight: .thin)
        static let ratingFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let stackViewSpacing: CGFloat = 5
        static let posterCornerRadius: CGFloat = 7
    }
    
    //MARK: - Properties
    
    private var posterImageView: UIImageView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var genresLabel: UILabel!
    private var ratingLabel: UILabel!
    
    private var dataTask: URLSessionDataTask?
    var viewModel: SearchCellModel? {
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
        configureRatingLabel()
        configureTitleLabels()
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
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = Constants.posterCornerRadius
        
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
    
    private func configureRatingLabel() {
        ratingLabel = UILabel()
        ratingLabel.font = Constants.ratingFont
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    private func configureTitleLabels() {
        titleLabel = UILabel()
        titleLabel.font = Constants.titleFont
        titleLabel.numberOfLines = 0
        
        subtitleLabel = UILabel()
        subtitleLabel.font = Constants.subtitleFont
        subtitleLabel.numberOfLines = 0
        
        genresLabel = UILabel()
        genresLabel.font = Constants.genresFont
        genresLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            genresLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = Constants.stackViewSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,
                                               constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    private func updateContent(with model: SearchCellModel) {
        posterImageView.image = UIImage(named: "poster_placeholder")
        dataTask = posterImageView.setImage(from: model.posterURL)
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        genresLabel.text = model.genres
        let rating = model.rating
        ratingLabel.text = "\(rating)"
        if rating > 7 {
            ratingLabel.textColor = .systemGreen
        } else if rating > 5 || rating == 0 {
            ratingLabel.textColor = .systemGray
        } else {
            ratingLabel.textColor = .systemRed
        }
    }
}
