//
//  UIView+Builder.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 15.06.2023.
//

import UIKit

extension UIView {
    /// Calling this function creates a new view
    public static func build<T: UIView>(_ builder: ((T) -> Void)? = nil) -> T {
        let view = T()
        view.translatesAutoresizingMaskIntoConstraints = false
        builder?(view)
        return view
    }
}
