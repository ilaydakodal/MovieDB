//
//  UIViewWithShadow.swift
//  MovieDB
//
//  Created by Ilayda Kodal on 16.06.2023.
//

import UIKit

// MARK: - UIViewWithShadow

/// A shadowed interface for UIView. Shadow position can be changed.
open class UIViewWithShadow: UIView {

    // MARK: Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public init(frame: CGRect, shadowPosition: ShadowPosition) {
        super.init(frame: frame)

        self.shadowPosition = shadowPosition

        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    // MARK: Open

    open var isProgrammatic = false {
        didSet {
            setup()
        }
    }

    // MARK: Public

    public enum ShadowPosition {
        case top, bottom, allSides
    }

    public var shadowColor: UIColor = .black {
        didSet {
            setup()
        }
    }

    public func setup() {
        layer.shadowColor = shadowColor.cgColor

        switch shadowPosition {
        case .top:
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 8)
            layer.masksToBounds = true
            layer.shadowOffset = CGSize(width: 0, height: 8)
            layer.shadowRadius = 2
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
            backgroundColor = .clear
        case .bottom:
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 14)
            layer.masksToBounds = true
            layer.shadowOffset = CGSize(width: 0, height: -13)
            layer.shadowRadius = 6
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
            backgroundColor = .clear
        case .allSides:
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.masksToBounds = false
            layer.shadowRadius = 6
        }
    }

    func setShadowOpacity(_ opacity: Float) {
        layer.shadowOpacity = opacity
    }

    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }

    // MARK: Private

    private var shadowPosition = ShadowPosition.allSides
}

// MARK: Programmatic Shadows
extension UIViewWithShadow { }
