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
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightText, for: .highlighted)
        button.backgroundColor = .link
        return button
    }()
    
    private let closeButtonHeight: CGFloat = 40
    
    var actionButtonDidClickHandler: EmptyCompletion?
        
    init() {
        super.init(frame: .zero)
        setupLC()
        addTargetToActionButton()
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
        containerView.addSubviews(errorLabel, errorDescriptionLabel, actionButton)
        
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
            
            actionButton.topAnchor.constraint(greaterThanOrEqualTo: errorDescriptionLabel.bottomAnchor, constant: 32),
            actionButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        actionButton.heightAnchor.constraint(equalToConstant: closeButtonHeight).isActive = true
    }
    
    private func addTargetToActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonDidClick), for: .touchUpInside)
    }
    
    private func setCornerRadiusToContainerView() {
        containerView.layer.cornerRadius = 16
    }
    
    private func setCornerRadiusToCloseButton() {
        actionButton.layer.cornerRadius = closeButtonHeight / 2
    }
    
    @objc private func actionButtonDidClick() {
        actionButtonDidClickHandler?()
    }
    
    //MARK: - Configure View Public Methods

    func configure(with model: ErrorViewModel) {
        errorLabel.text = model.title
        errorDescriptionLabel.text = model.description
    }
    
    func setActionButtonTitle(_ title: String) {
        actionButton.setTitle(title, for: .normal)
    }
    
    func setActionButton(isEnabled: Bool) {
        actionButton.isEnabled = isEnabled
        actionButton.backgroundColor = isEnabled ? .link : .lightGray
    }
    
}
