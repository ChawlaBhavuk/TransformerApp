//
//  UIView+Extension.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit

extension UIView {
    func applyShadow() {
       self.layer.cornerRadius = 4
       self.layer.shadowColor = UIColor.black.cgColor
       self.layer.shadowOffset = CGSize(width: 0, height: 1)
       self.layer.shadowOpacity = 0.8
       self.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
       self.layer.shadowRadius = 2
    }

    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")

        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        self.layer.add(animation, forKey: nil)
    }

    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                 bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                 paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                 paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)

        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom

            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
