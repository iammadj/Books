//
//  ErrorView.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 01/08/21.
//

import UIKit


protocol ErrorViewProtocol {
    
    func configureWith(errorTitle: String, errorDescription: String)
    
}


class ErrorView: UIView {
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .lightGray
        containerView.addShadow(offset: CGSize(width: 0, height: 4), radius: 8, cornerRadius: 16)
        return containerView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    private let errorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightText, for: .highlighted)
        button.backgroundColor = .link
        return button
    }()
    
    private let closeButtonHeight: CGFloat = 40
    
    var closeButtonDidClickHandler: EmptyCompletion?
        
    init() {
        super.init(frame: .zero)
        setupLC()
        addTargetToCloseButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadiusToContainerView()
        setCornerRadiusToCloseButton()
    }
    
    private func setupLC() {
        addSubview(containerView)
        containerView.addSubviews(errorLabel, errorDescriptionLabel, closeButton)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            errorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            errorDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            errorDescriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: errorLabel.bottomAnchor, constant: 16),
            errorDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            closeButton.topAnchor.constraint(greaterThanOrEqualTo: errorDescriptionLabel.bottomAnchor, constant: 32),
            closeButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
            closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        closeButton.heightAnchor.constraint(equalToConstant: closeButtonHeight).isActive = true
    }
    
    private func addTargetToCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonDidClick), for: .touchUpInside)
    }
    
    private func setCornerRadiusToContainerView() {
        containerView.layer.cornerRadius = 16
    }
    
    private func setCornerRadiusToCloseButton() {
        closeButton.layer.cornerRadius = closeButtonHeight / 2
    }
    
    @objc private func closeButtonDidClick() {
        closeButtonDidClickHandler?()
    }
    
    //MARK: - Configure View Public Methods

    func configureWith(with model: ErrorViewModel) {
        errorLabel.text = model.title
        errorDescriptionLabel.text = model.description
    }
    
}
