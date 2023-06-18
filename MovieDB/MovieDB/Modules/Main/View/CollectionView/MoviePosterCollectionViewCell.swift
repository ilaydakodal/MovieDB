//
//  MoviePosterCollectionViewCell.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit
import SnapKit

// MARK: - MoviePosterCollectionViewCell

final class MoviePosterCollectionViewCell: UICollectionViewCell {

    // MARK: Initialisers

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View
    private lazy var containerView: UIViewWithShadow = .build { view in
        view.layer.cornerRadius = 10
        view.backgroundColor = .clear
        view.setShadowOpacity(0.15)
        view.shadowColor = .white
    }

    private lazy var topStackView: UIStackView = .build { stackView in
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
    }

    private lazy var stackViewSpacer: UIView = .build()

    private lazy var posterImageView: UIImageView = .build { imageView in
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
    }

    private lazy var ratingContainerView: UIViewWithShadow = .build { view in
        view.layer.cornerRadius = 15
        view.backgroundColor = .black
        view.layer.opacity = 0.7
        view.setShadowOpacity(0.4)
    }

    private lazy var ratingLabel: UILabel = .build { label in
        label.font = label.font.withSize(11)
        label.textColor = .white
        label.text = "4.6" // TODO: Remove mock data!!!
    }

    private lazy var releaseDateLabel: UILabel = .build { label in
        label.text = "1996" // TODO: Remove mock data!!!
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = label.font.withSize(11)
    }

    private lazy var movieTitleContainerView: UIViewWithShadow = .build { view in
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.setShadowOpacity(0.4)
    }

    private lazy var movieTitleLabel: UILabel = .build { label in
        label.numberOfLines = 0
        label.textColor = .white
        label.font = label.font.withSize(9)
        label.textAlignment = .center
    }
}

// MARK: - SetUp
extension MoviePosterCollectionViewCell {
    private func setUpUI() {
        setUpViews()
        configureConstarints()
    }

    private func setUpViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(posterImageView)
        posterImageView.addSubview(topStackView)
        ratingContainerView.addSubview(ratingLabel)
        topStackView.addArrangedSubviews([ratingContainerView, stackViewSpacer, releaseDateLabel])
        movieTitleContainerView.addSubview(movieTitleLabel)
        containerView.addSubview(movieTitleContainerView)
    }

    func configureView(with model: MovieModel) {
        posterImageView.setImage(from: model.posterPath)
        let formattedValue = String(format: "%.2f", model.voteAverage) // TODO: Implement format extension
        ratingLabel.text = "\(formattedValue)"
        movieTitleLabel.text = model.title
        releaseDateLabel.text = model.releaseDate?.extractYearFromDateString() ?? ""
    }
}

// MARK: - Constraints
extension MoviePosterCollectionViewCell {
    private func configureConstarints() {
        layoutContainerView()
        layoutTopStackView()
        layoutMovieTitleContainerView()
    }

    private func layoutContainerView() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func layoutTopStackView() {
        ratingContainerView.snp.makeConstraints {
            $0.size.equalTo(30)
        }

        ratingLabel.snp.makeConstraints {
            $0.center.equalToSuperview().inset(2)
        }

        topStackView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview().inset(8)
        }
    }

    private func layoutMovieTitleContainerView() {
        movieTitleContainerView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }

        movieTitleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
    }
}
