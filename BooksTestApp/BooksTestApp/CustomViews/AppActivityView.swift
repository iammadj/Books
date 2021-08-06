//
//  AppActivityView.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import UIKit


class AppActivityView: UIView {
    
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
        indicatorView.color = .gray
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
        backgroundColor = .clear
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
    
    private func setContainerView(isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.6) {
                self?.containerView.isHidden = isHidden
            }
        }
    }
    
    //MARK: - Public IndicatorView Setting Methods
    
    func startAnimating() {
        setContainerView(isHidden: false)
        indicatorView.startAnimating()
    }
    
    func stopAnimating() {
        setContainerView(isHidden: true)
        indicatorView.stopAnimating()
    }
    
}
