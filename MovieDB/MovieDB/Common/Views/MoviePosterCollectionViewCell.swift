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
    // MARK: - View
    private lazy var containerView: UIView = .build { view in
        view.backgroundColor = .clear
    }

    private lazy var topStackView: UIStackView = .build { stackView in
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }

    private lazy var posterImageView: UIImageView = .build()

    private lazy var ratingContainerView: UIView = .build { view in
        view.layer.cornerRadius = 8
    }

    private lazy var ratingLabel: UILabel = .build { label in
        label.text = "4.6" // TODO: Remove mock data!!!
    }

    private lazy var releaseDateLabel: UILabel = .build { label in
        label.text = "1996" // TODO: Remove mock data!!!
        label.backgroundColor = .white
        label.textColor = .black
//        label.font =
    }

    private lazy var movieTitleContainerView: UIView = .build { view in
        view.backgroundColor = .white
    }

    private lazy var movieTitleLabel: UILabel = .build { label in
        label.text = "Batman" // TODO: Remove mock data!!!
    }

    // MARK: Initialisers
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        topStackView.addArrangedSubviews([ratingContainerView, releaseDateLabel])
        movieTitleContainerView.addSubview(movieTitleLabel)
        posterImageView.addSubview(movieTitleContainerView)
    }

// TODO: - Configure image and lable here
///    func configure(with model: UIModel) {
///        imageView.setImage(from: URL(string: model.image ?? .empty))
///        title.text = model.title
///    }
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
    }

    private func layoutTopStackView() {
        topStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }
    }

    private func layoutMovieTitleContainerView() {
        movieTitleContainerView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        movieTitleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
