//
//  AppIndicatorView.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import UIKit


class AppIndicatorView: UIView {
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.addShadow(offset: CGSize(width: 0, height: 4), radius: 4, cornerRadius: 16)
        return containerView
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.style = .medium
        indicatorView.color = .link
        indicatorView.tintColor = .red
        return indicatorView
    }()
    
    private let widthHeight: CGFloat = 64

    init() {
        super.init(frame: .zero)
        setupLC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadiusToContainerView()
    }
    
    //MARK: - Private Methods
    
    private func setupLC() {
        addSubview(containerView)
        containerView.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: widthHeight),
            containerView.heightAnchor.constraint(equalToConstant: widthHeight)
        ])
        
        NSLayoutConstraint.activate([
            indicatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            indicatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            indicatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            indicatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setCornerRadiusToContainerView() {
        containerView.layer.cornerRadius = 16
    }
    
    //MARK: - Public IndicatorView Setting Methods
    
    func startAnimating() {
        indicatorView.startAnimating()
    }
    
    func stopAnimating() {
        indicatorView.stopAnimating()
    }
    
}
