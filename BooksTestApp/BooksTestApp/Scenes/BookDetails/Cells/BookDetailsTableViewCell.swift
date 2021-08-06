//
//  BookDetailsTableViewCell.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 04/08/21.
//

import UIKit


class BookDetailsTableViewCell: UITableViewCell {
    
    private let stackView: UIStackView = {
        let stack = UIStackView(spacing: 0)
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
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let bookDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private var item: Book?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(with item: Book, image: UIImage) {
        self.item = item
        
        bookImageView.image = image
        bookTitleLabel.text = item.title
        bookAuthorLabel.text = item.authors
        bookDescriptionLabel.text = item.description
    }
    
    //MARK: - Private Methods
    
    private func setupLC() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(bookImageView, bookTitleLabel, bookAuthorLabel, bookDescriptionLabel)
        
        stackView.setCustomSpacing(32, after: bookImageView)
        stackView.setCustomSpacing(16, after: bookTitleLabel)
        stackView.setCustomSpacing(16, after: bookAuthorLabel)
//        contentView.addSubviews(bookImageView, bookTitleLabel, bookAuthorLabel, bookDescriptionLabel)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
        
        stackView.constraints.forEach { $0.priority = UILayoutPriority(999) }
        
//        NSLayoutConstraint.activate([
//            bookImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 32),
//            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
//            bookImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -32),
//            bookImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//
//            bookTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
//            bookTitleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 32),
//            bookTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
//
//            bookAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
//            bookAuthorLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: 32),
//            bookAuthorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
//
//            bookDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
//            bookDescriptionLabel.topAnchor.constraint(equalTo: bookAuthorLabel.bottomAnchor, constant: 32),
//            bookDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
//            bookDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
//        ])
    }
    
}
