//
//  DetailView.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 18.06.2023.
//

import UIKit
import SnapKit

final class DetailView: UIView {

    // MARK: - Initialisers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View

    private lazy var verticalStackView: UIStackView = .build { stackView in
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
    }

    private lazy var infoContainerView: UIViewWithShadow = .build { view in
        view.shadowColor = .black
        view.setShadowOpacity(0.5)
    }

    private lazy var infoViewHorizontalStack: UIStackView = .build { stackView in
        stackView.axis = .horizontal
        stackView.spacing = 8
    }

    private lazy var infoViewVerticalStack: UIStackView = .build { stackView in
        stackView.axis = .vertical
        stackView.spacing = 4
    }

    private lazy var backdropImageContainerView: UIView = .build()

    private lazy var spacer: UIView = .build()

    private lazy var backdropImageView: UIImageView = .build { imageView in
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
    }

    private lazy var releaseDatelabel: UILabel = .build { label in
        label.textColor = .white
    }

    private lazy var genresLabel: UILabel = .build { label in
        label.textColor = .white
    }

    private lazy var runtimeLabel: UILabel = .build { label in
        label.textColor = .white
    }

    private lazy var rateContainerView: UIViewWithShadow = .build { view in
        view.layer.cornerRadius = 20
        view.backgroundColor = .black
        view.layer.opacity = 0.7
        view.setShadowOpacity(0.4)
    }

    private lazy var rateLabel: UILabel = .build { label in
        label.font = label.font.withSize(11)
        label.textAlignment = .center
        label.textColor = .white
    }

    private lazy var titleLabel: UILabel = .build { label in
        label.textAlignment = .center
        label.textColor = .white
    }

    private lazy var overviewLabel: UILabel = .build { label in
        label.numberOfLines = .zero
        label.textColor = .white
    }

    // MARK: - Configure

    func configureView(with model: MovieModel) {
        backdropImageView.setImage(from: model.backdropPath ?? "")
        self.releaseDatelabel.text = model.releaseDate?.makePrettyDateString()
        self.genresLabel.text = model.genres?.first?.name
        self.runtimeLabel.text = "\(model.runtime)"
        let formattedValue = String(format: "%.2f", model.voteAverage) // TODO: Implement format extension
        self.rateLabel.text = "\(formattedValue)"
        self.titleLabel.text = model.title
        self.overviewLabel.text = model.overview
    }
}

// MARK: - setUp

extension DetailView {
    private func setUpUI() {
       addSubview(infoContainerView)
        infoContainerView.addSubview(backdropImageContainerView)
        infoContainerView.addSubview(verticalStackView)
        backdropImageContainerView.addSubview(backdropImageView)
        verticalStackView.addArrangedSubviews(
            [infoViewHorizontalStack,
             titleLabel,
             overviewLabel]
        )
        rateContainerView.addSubview(rateLabel)
        infoViewHorizontalStack.addArrangedSubviews([infoViewVerticalStack, spacer, rateContainerView])
        infoViewVerticalStack.addArrangedSubviews([releaseDatelabel, genresLabel, runtimeLabel])
        
    }

    private func configureConstraints() {
        rateContainerView.snp.makeConstraints {
            $0.size.equalTo(40)
        }

        rateLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview()
        }

        infoContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        verticalStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(40)
        }

        backdropImageContainerView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.bottom.equalTo(verticalStackView.snp_topMargin)
        }

        backdropImageView.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
