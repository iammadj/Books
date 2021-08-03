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
        return label
    }()
    
    private let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let bookDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var item: Book?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLC()
        selectionStyle = .none
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
        
        layoutIfNeeded()
    }
    
    //MARK: - Private Methods
    
    private func setupLC() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(bookImageView, bookTitleLabel, bookAuthorLabel, bookDescriptionLabel)
        stackView.setCustomSpacing(32, after: bookImageView)
        stackView.setCustomSpacing(16, after: bookTitleLabel)
        stackView.setCustomSpacing(16, after: bookAuthorLabel)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
}
