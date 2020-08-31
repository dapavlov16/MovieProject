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
    func showError()
    func changeFavoriteState(isFavorite: Bool)
}

final class DetailsViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let backdropImageAlpha: CGFloat = 0.75
        static let backdropHeightRatio: CGFloat = 0.562
        static let posterWidth: CGFloat = 150
        static let posterHeightRatio: CGFloat = 1.5
        static let titleLabelsSpacing: CGFloat = 5
        static let titleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let originalTitleFont = UIFont.systemFont(ofSize: 14, weight: .thin)
        static let taglineFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
        static let genresFont = UIFont.systemFont(ofSize: 12, weight: .thin)
        static let countriesRuntimeFont = UIFont.systemFont(ofSize: 12, weight: .thin)
        static let overviewFont = UIFont.systemFont(ofSize: 16)
        static let errorDescriptionFont = UIFont.systemFont(ofSize: 18, weight: .thin)
        static let defaultErrorText = "Что-то пошло не так..."
    }
    
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
    private var errorDescriptionLabel: UILabel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        configureScrollView()
        configureBackdropImageView()
        configurePosterImageView()
        configureTitleLabels()
        configureOverviewLabel()
        configureAddToFavoriteButton()
        configureErrorDescriptionLabel()
        
        interactor?.loadDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.checkFavoriteState()
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
        backdropImageView.alpha = Constants.backdropImageAlpha
        
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backdropImageView)
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor,
                                                      multiplier: Constants.backdropHeightRatio)
        ])
    }
    
    private func configurePosterImageView() {
        posterImageView = UIImageView()
        dropShadow(view: posterImageView)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor,
                                                 constant: -30),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                     constant: 20),
            posterImageView.widthAnchor.constraint(equalToConstant: Constants.posterWidth),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor,
                                                    multiplier: Constants.posterHeightRatio)
        ])
    }
    
    private func configureTitleLabels() {
        titleLabel = UILabel()
        titleLabel.font = Constants.titleFont
        titleLabel.numberOfLines = 0
        
        originalTitleLabel = UILabel()
        originalTitleLabel.font = Constants.originalTitleFont
        originalTitleLabel.numberOfLines = 0
        
        taglineLabel = UILabel()
        taglineLabel.font = Constants.taglineFont
        taglineLabel.numberOfLines = 0
        
        genresLabel = UILabel()
        genresLabel.font = Constants.genresFont
        genresLabel.numberOfLines = 0
        
        countriesRuntimeLabel = UILabel()
        countriesRuntimeLabel.font = Constants.countriesRuntimeFont
        countriesRuntimeLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       originalTitleLabel,
                                                       taglineLabel,
                                                       genresLabel,
                                                       countriesRuntimeLabel])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = Constants.titleLabelsSpacing
        
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
        overviewLabel.font = Constants.overviewFont
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
    
    private func configureAddToFavoriteButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "В избранное",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addToFavorite))
    }
    
    private func configureErrorDescriptionLabel() {
        errorDescriptionLabel = UILabel()
        errorDescriptionLabel.font = Constants.errorDescriptionFont
        errorDescriptionLabel.numberOfLines = 0
        errorDescriptionLabel.text = Constants.defaultErrorText
        errorDescriptionLabel.textAlignment = .center
        errorDescriptionLabel.fadeOut(withDuration: 0)
        
        errorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorDescriptionLabel)
        NSLayoutConstraint.activate([
            errorDescriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            errorDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
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
    
    //MARK: - Actions
    
    @objc private func addToFavorite(_ sender: Any) {
        interactor?.addToFavorite()
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

//MARK: - DetailsViewControllerInput
extension DetailsViewController: DetailsViewControllerInput {
    
    func showDetails(model: DetailsModel) {
        errorDescriptionLabel.fadeOut(withDuration: 0)
        contentView.fadeIn(withDuration: 0.5)
        
        title = model.title
        posterImageView.image = UIImage(named: "poster_placeholder")
        backdropImageView.image = UIImage(named: "backdrop_placeholder")
        backdropImageView.setImage(from: model.backdropUrl)
        posterImageView.setImage(from: model.posterUrl)
        titleLabel.text = model.title
        originalTitleLabel.text = model.titleDescription
        taglineLabel.text = model.tagline
        genresLabel.text = model.genresString
        countriesRuntimeLabel.text = model.countriesRuntimeString
        overviewLabel.text = model.overview
    }
    
    func showError() {
        contentView.fadeOut(withDuration: 0)
        errorDescriptionLabel.fadeIn(withDuration: 1)
    }
    
    func changeFavoriteState(isFavorite: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = !isFavorite
    }
}
