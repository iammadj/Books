//
//  MainScreenCollectionViewCell.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 01/08/21.
//

import UIKit
import Kingfisher


class MainScreenCollectionViewCell: UICollectionViewCell {
        
    private var containerView: MainContainerView? {
        didSet {
            if containerView != nil {
                containerView?.translatesAutoresizingMaskIntoConstraints = false
                containerView?.preservesSuperviewLayoutMargins = true
            }
        }
    }
            
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLC()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    //MARK: - Configure cell
    
    func configure(with item: Book, image: UIImage) {
        containerView = MainContainerView(with: item, image: image)
        layoutIfNeeded()
    }
    
    //MARK: - Setup Layout Constraints
    
    private func setupLC() {
        guard containerView != nil else { return }
        contentView.addSubview(containerView!)
        
        NSLayoutConstraint.activate([
            containerView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
}
