//
//  DetailsViewController.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 12.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

protocol DetailsViewControllerInput: AnyObject {
    func showDetails(model: DetailsModel)
}

final class DetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: DetailsInteractorInput?
    
    private var contentView: UIView!
    private var backdropImageView: UIImageView!
    private var posterImageView: UIImageView!
    private var titleLabel: UILabel!
    private var originalTitleLabel: UILabel!
    private var taglineLabel: UILabel!
    private var genresLabel: UILabel!
    private var countriesRuntimeLabel: UILabel!
    private var overviewLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureScrollView()
        configureBackdropImageView()
        configurePosterImageView()
        configureTitleLabels()
        configureOverviewLabel()
        
        interactor?.loadDetails()
    }
    
    //MARK: - Private
    
    private func configureScrollView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureBackdropImageView() {
        backdropImageView = UIImageView()
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.alpha = 0.75
        contentView.addSubview(backdropImageView)
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor,
                                                      multiplier: 0.562)
        ])
    }
    
    private func configurePosterImageView() {
        posterImageView = UIImageView()
        dropShadow(view: posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor,
                                                 constant: -50),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                     constant: 20),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor,
                                                    multiplier: 1.5)
        ])
    }
    
    private func configureTitleLabels() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.numberOfLines = 0
        
        originalTitleLabel = UILabel()
        originalTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        originalTitleLabel.numberOfLines = 0
        
        taglineLabel = UILabel()
        taglineLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        taglineLabel.numberOfLines = 0
        
        genresLabel = UILabel()
        genresLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        genresLabel.numberOfLines = 0
        
        countriesRuntimeLabel = UILabel()
        countriesRuntimeLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        countriesRuntimeLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       originalTitleLabel,
                                                       taglineLabel,
                                                       genresLabel,
                                                       countriesRuntimeLabel])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor,
                                           constant: 10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: posterImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,
                                               constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -10)
        ])
    }
    
    private func configureOverviewLabel() {
        overviewLabel = UILabel()
        overviewLabel.font = UIFont.systemFont(ofSize: 16)
        overviewLabel.numberOfLines = 0
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overviewLabel)
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor,
                                               constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -20),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func dropShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale;
    }
}

//MARK: - DetailsViewControllerInput
extension DetailsViewController: DetailsViewControllerInput {
    func showDetails(model: DetailsModel) {
        backdropImageView.setImage(from: model.backdropUrl)
        posterImageView.setImage(from: model.posterUrl)
        titleLabel.text = model.title
        originalTitleLabel.text = model.titleDescription
        taglineLabel.text = model.tagline
        genresLabel.text = model.genresString
        countriesRuntimeLabel.text = model.countriesRuntimeString
        overviewLabel.text = model.overview
    }
}
