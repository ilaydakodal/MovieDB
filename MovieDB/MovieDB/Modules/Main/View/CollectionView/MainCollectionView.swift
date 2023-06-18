//
//  MainCollectionView.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit
import SnapKit

protocol MainCollectionViewDataSource: UICollectionViewDelegate {
    func applySnapshot(with movie: [MovieModel])
}

final class MainCollectionView: UIView, UICollectionViewDelegate {
    let pageSize = 20
    var currentPage = 1

    // MARK: - Views

    private lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout.makeCompositionalLayout()
        )
        collectionView.registerClass(MoviePosterCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    // MARK: Internal

    // MARK: Type Alias

    private typealias DataSource = UICollectionViewDiffableDataSource<MainCollcetionViewSections, MovieModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<MainCollcetionViewSections, MovieModel>

    // MARK: Private

    private lazy var dataSource: DataSource = makeDataSource()
    private var collectionViewLayout: MainCompositionalLayoutMaking

    // MARK: - Initialisers

    override init(frame: CGRect) {
        collectionViewLayout = MainCompositionalLayoutMaker()
        super.init(frame: frame)
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension MainCollectionView {
    // MARK: Private

    private func setUpUI() {
        addSubview(mainCollectionView)
        backgroundColor = .clear

        setCollectionViewConstraints()
        setCollectionViewLayout()
        mainCollectionView.dataSource = dataSource
    }

    private func setCollectionViewLayout() {
        mainCollectionView.collectionViewLayout = collectionViewLayout.makeCompositionalLayout()
    }

    private func setCollectionViewConstraints() {
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: mainCollectionView,
            cellProvider: { collectionView, indexPath, item -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MoviePosterCollectionViewCell
                cell.configureView(with: item)
                return cell
            }
        )
        return dataSource
    }
}

// MARK: - Layout Related

extension MainCollectionView: MainCollectionViewDataSource {
    func applySnapshot(with movie: [MovieModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.verticalListSection])
        snapshot.appendItems(movie, toSection: .verticalListSection)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
