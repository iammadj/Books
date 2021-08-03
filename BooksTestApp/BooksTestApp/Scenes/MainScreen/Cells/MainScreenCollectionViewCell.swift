//
//  MainScreenCollectionViewCell.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 01/08/21.
//

import UIKit
import Kingfisher


class MainScreenCollectionViewCell: UICollectionViewCell {
        
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
        return label
    }()
    
    private let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var item: Book?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 16
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        item = nil
    }
    
    func configure(with item: Book, image: UIImage) {
        self.item = item
        
        bookImageView.image = image
        bookTitleLabel.text = item.title
        bookAuthorLabel.text = item.authors
        
        setupLC()
    }
    
    private func setupLC() {
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubviews(bookImageView, bookTitleLabel, bookAuthorLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        setNeedsLayout()
    }
    
}

extension UITableViewCell {
    
    var tableView: UITableView? { parentView(of: UITableView.self) }
    
    func reload() {
        self.tableView?.beginUpdates()
        self.tableView?.endUpdates()
    }
    
}

extension UICollectionViewCell {
    
    var collectionView: UICollectionView? { parentView(of: UICollectionView.self) }
    
}

extension UIView {
    
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
    
}


extension Date {
    
    var hour: String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
    
}
