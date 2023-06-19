//
//  SerachBarTextField.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 18.06.2023.
//

import UIKit
import SnapKit

// MARK: - SearchBarTextFieldDelegate

protocol SearchBarTextFieldDelegate: AnyObject {
    func searchBarTextFieldDidTapSearchButton(_ searchBarTextField: SearchBarTextField)
    func searchBarTextField(_ searchBarTextField: SearchBarTextField, didChanged text: String)
}

// MARK: - SearchBarTextField

final class SearchBarTextField: UIView {

    // MARK: Private

    private enum Constant {
        static let shadowViewHeight: CGFloat = 50
        static let horizontalSpacing: CGFloat = 16
        static let containerCornerRadius: CGFloat = 25
        static let containerShadowOpacity: Float = 0.5
    }

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setUpUI()
    }

    // MARK: Internal

    weak var delegate: SearchBarTextFieldDelegate?

    var currentText: String? {
        searchTextField.text
    }

    func makeTextFieldFirstResponder() {
        searchTextField.becomeFirstResponder()
    }

    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.searchButton.isHidden = true
            self.searchActivityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.searchButton.isHidden = false
            self.searchActivityIndicator.stopAnimating()
        }
    }

    func updatePlaceholder(placeholder: String) {
        searchTextField.placeholder = placeholder
    }

    func setSearchText(text: String?) {
        searchTextField.text = text
    }

    // MARK:  - View

    // MARK: Private

    private lazy var containerShadowView: UIViewWithShadow = .build { view in
        view.backgroundColor = .white
        view.setCornerRadius(Constant.containerCornerRadius)
        view.setShadowOpacity(Constant.containerShadowOpacity)
        view.shadowColor = .white.withAlphaComponent(0.5)
    }

    private lazy var searchButtonVerticalStackView: UIStackView = .build { stackView in
        stackView.axis = .vertical
        stackView.spacing = .zero
    }

    private lazy var searchButton: UIButton = .build { button in
        button.setTitle(nil, for: .normal)
        button.addTarget(self, action: #selector(self.searchButtonTapped), for: .touchUpInside)
        let image = UIImage(named: "search")
        button.setImage(image, for: .normal)
    }

    private lazy var searchActivityIndicator: UIActivityIndicatorView = .build { activityIndicator in
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = .black
    }

    private lazy var searchFieldHorizontalStackView: UIStackView = .build { stackView in
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = .zero
    }

    private lazy var spacer: UIView = .build()

    private lazy var searchTextField: UITextField = .build { textField in
        textField.clearButtonMode = .always
        textField.textColor = .black
        textField.addTarget(self, action: #selector(self.searchTextChanged), for: .editingChanged)
    }
}

// MARK: - Configure UI

extension SearchBarTextField {
    private func setUpUI() {
        addSubviews()
        configureConstraints()
    }

    private func addSubviews() {
        addSubview(containerShadowView)
        containerShadowView.addSubview(searchButtonVerticalStackView)
        searchButtonVerticalStackView.addArrangedSubviews(
            [searchButton,
             searchActivityIndicator]
        )
        containerShadowView.addSubview(searchFieldHorizontalStackView)
        searchFieldHorizontalStackView.addArrangedSubview(searchTextField)
    }

    private func configureConstraints() {
        containerShadowView.snp.makeConstraints {
            $0.height.equalTo(Constant.shadowViewHeight)
            $0.edges.equalToSuperview()
        }

        searchButton.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }

        searchButtonVerticalStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(containerShadowView.snp.leading).offset(Constant.horizontalSpacing)
            $0.trailing.equalTo(searchButtonVerticalStackView)
        }

        searchFieldHorizontalStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(searchButtonVerticalStackView.snp.trailing).offset(Constant.horizontalSpacing)
            $0.trailing.equalTo(containerShadowView.snp.trailing).offset(-Constant.horizontalSpacing)
        }
    }
}

// MARK: - Actions

extension SearchBarTextField {
    @objc
    private func searchButtonTapped() {
        delegate?.searchBarTextFieldDidTapSearchButton(self)
    }

    @objc
    private func searchTextChanged() {
        delegate?.searchBarTextField(self, didChanged: searchTextField.text ?? "") // TODO: add orempty extension
    }
}
