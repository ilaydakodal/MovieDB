//
//  MainViewController.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit
import SnapKit

protocol MainViewControlable: AnyObject {
    func applySnapshot(with movie: [MovieModel])
    func didStartSearch()
    func didEndSearch()
}

class MainViewController: UIViewController, MainViewControlable {
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    var viewModel: MainViewModel?

    // MARK: - Initialisers

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpView()
    }

    private lazy var containerView: UIView = .build { view in
        view.backgroundColor = .clear
    }

    private lazy var searchField: SearchBarTextField = .build { searchField in
        searchField.tintColor = .black
        searchField.delegate = self
    }

    private lazy var collectionView: MainCollectionView = .build()

    private func setUpView() {
        view.addSubview(containerView)
        containerView.addSubview(searchField)
        containerView.addSubview(collectionView)
        configureConstaints()
    }

    private func configureConstaints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        searchField.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
        }

        collectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(searchField.snp_bottomMargin).offset(16)
        }
    }

    func applySnapshot(with movie: [MovieModel]) {
        collectionView.applySnapshot(with: movie)
    }
}

extension MainViewController: SearchBarTextFieldDelegate {
    func searchBarTextFieldDidTapSearchButton(_ searchBarTextField: SearchBarTextField) {
        searchBarTextField.makeTextFieldFirstResponder()
    }

    func searchTextChanged(text: String) {
        searchField.showActivityIndicator()
        viewModel?.searchMovies(text: text)
    }

    func searchBarTextField(_ searchBarTextField: SearchBarTextField, didChanged text: String) {
        searchTextChanged(text: text)
        viewModel?.searchMovies(text: text)
    }

    func didStartSearch() {
        searchField.showActivityIndicator()
    }

    func didEndSearch() {
        searchField.hideActivityIndicator()
    }
}
