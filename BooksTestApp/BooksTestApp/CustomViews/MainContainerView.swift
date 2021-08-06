//
//  MainContainerView.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 04/08/21.
//

import UIKit

class MainContainerView: UIView {

    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.addShadow(offset: .init(width: 0, height: 4), radius: 4, cornerRadius: 16)
        return containerView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView(spacing: 16)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
        
    init(with item: Book, image: UIImage) {
        super.init(frame: .zero)
        backgroundColor = .clear
        configureView(with: image, item: item)
        setupLC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 16
    }
    
    //MARK: - Set Values
    
    private func configureView(with image: UIImage, item: Book) {
        bookImageView.image = image
        bookTitleLabel.text = item.title
        bookAuthorLabel.text = item.authors
    }
    
    //MARK: - Setup Layout Constraints
    
    private func setupLC() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubviews(bookImageView, bookTitleLabel, bookAuthorLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
}
