//
//  UIView+extensions.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 31/07/21.
//

import UIKit


extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addShadow(with color: UIColor = .darkGray,
                   offset: CGSize = CGSize(width: 0, height: 2),
                   opacity: Float = 0.5,
                   radius: CGFloat = 2.0,
                   cornerRadius: CGFloat = 0.0) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
}
