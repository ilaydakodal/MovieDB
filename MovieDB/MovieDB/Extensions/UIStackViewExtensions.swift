//
//  UIStackViewExtensions.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit

extension UIStackView {
    /// Helps to add multiple subviews in one line
    @discardableResult
    public func addArrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach(addArrangedSubview)
        return self
    }
}
