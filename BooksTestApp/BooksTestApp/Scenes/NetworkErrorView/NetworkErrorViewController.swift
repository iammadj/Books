//
//  NetworkErrorViewController.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol NetworkErrorViewProtocol: AnyObject {

    var presenter: NetworkErrorPresenterProtocol?  { get set }
    
    func set(errorViewModel: ErrorViewModel)
    
}


class NetworkErrorViewController: UIViewController, NetworkErrorViewProtocol {

	var presenter: NetworkErrorPresenterProtocol?
    
    private let errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.setActionButtonTitle("Retry")
        return errorView
    }()
    
    private var isNetworkReachable: Bool { NetworkReachabilityHelper.isConnectedToInternet }

	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLC()
        dismissIfNetworkBecameReachable(isReachable: isNetworkReachable)
        setActionButton(isEnabled: isNetworkReachable)
        actionButtonDidClick()
    }
    
    private func setupLC() {
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func dismissIfNetworkBecameReachable(isReachable: Bool) {
        if isReachable {
            presenter?.dismiss()
        }
    }
    
    private func setActionButton(isEnabled: Bool) {
        errorView.setActionButton(isEnabled: isEnabled)
    }
    
    private func actionButtonDidClick() {
        errorView.actionButtonDidClickHandler = { [weak self] in
            guard let self = self else { return }
            if self.isNetworkReachable {
                self.presenter?.dismiss()
            }
        }
    }

}

//MARK: - Protocol Methods

extension NetworkErrorViewController {
    
    func set(errorViewModel: ErrorViewModel) {
        errorView.configureWith(with: errorViewModel)
    }
    
}
