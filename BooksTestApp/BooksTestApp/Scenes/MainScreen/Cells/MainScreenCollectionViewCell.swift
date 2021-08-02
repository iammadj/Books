//
//  MainScreenCollectionViewCell.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 01/08/21.
//

import UIKit
import Kingfisher


class MainScreenCollectionViewCell: UICollectionViewCell {
    
    static var id: String { String(describing: self) }
    
    private let containerStackView: UIStackView = {
        let containerStackView = UIStackView(spacing: 4)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        return containerStackView
    }()
    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private var item: Book?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func setupLC() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubivews(bookImageView, bookAuthorLabel, bookTitleLabel)
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    //MARK: - Configure Cell Method
    
    func configure(with book: Book) {
        item = book
        bookImageView.kf.setImage(with: book.volumeInfo.imageLinks.thumbnail, placeholder: UIImage(named: "book3"), options: [.backgroundDecode])
        bookAuthorLabel.text = book.volumeInfo.authors.joined(separator: String().capitalized)
        bookTitleLabel.text = book.volumeInfo.title
    }
    
}
