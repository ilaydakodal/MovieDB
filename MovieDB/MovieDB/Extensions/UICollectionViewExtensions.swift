//
//  UICollectionViewExtensions.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit

// MARK: - ReusableView

/// ReusableView protocol.
public protocol ReusableView: AnyObject { }

/// ReusableView extension, Provides reuseIdentifier from class name.
extension ReusableView where Self: UIView {
    public static var reuseIdentifier: String {
        String(describing: self)
    }

    public func prepareForReuse() { }
}

extension UICollectionReusableView: ReusableView { }

/// Extension of UICollectionView. Adds safety and ease of use.
extension UICollectionView {
    /// Registers Class for any UICollectionViewCell subclass.
    public func registerClass<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    ///   Dequeus reusable CollectionViewCell and Returns.
    ///
    ///   - Parameter indexPath: Index path of cell.
    ///
    ///   - Returns: CollectionViewCell for given index path.
    public func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("🚨 Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    /// - Tag: Dequeue Cell
    public func dequeueReusable<T>(cellAt indexPath: IndexPath) -> T? where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            assertionFailure("Cannot dequeue cellType \(T.self) at indexPath: \(indexPath)")
            return nil
        }

        return cell
    }

    public func reloadData(with completion: @escaping () -> Void) {
        reloadData()
        performBatchUpdates(nil, completion: { _ in
            completion()
        })
    }
}
