//
//  MainCompositionalLayoutMaker.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit

// MARK: - MainCompositinalLayoutMaker protocol

protocol MainCompositionalLayoutMaking {
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout
}

// MARK: - MainCompositinalLayoutMaker

final class MainCompositionalLayoutMaker: MainCompositionalLayoutMaking {
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(section: makeSectionn())
    }
// TODO: Fix Constants
    private func makeSectionn() -> NSCollectionLayoutSection {
        let item = makeItem()
        let group = makeGroup(item: item)
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }

    private func makeItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        return item
    }

    private func makeGroup(item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.27)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        group.interItemSpacing = .fixed(8)
        return group
    }
}
