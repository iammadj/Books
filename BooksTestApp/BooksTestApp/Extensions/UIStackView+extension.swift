//
//  UIStackView+extension.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 01/08/21.
//

import UIKit


extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis = .vertical, alignment: Alignment = .fill, distribution: Distribution = .fill, spacing: CGFloat) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
    
    func addArrangedSubivews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
    
}
