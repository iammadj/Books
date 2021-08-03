//
//  ErrorViewViewController.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol ErrorViewViewProtocol: AnyObject {

    var presenter: ErrorViewPresenterProtocol?  { get set }
    
    func set(errorViewModel: ErrorViewModel)
    
}


class ErrorViewViewController: UIViewController, ErrorViewViewProtocol {

	var presenter: ErrorViewPresenterProtocol?
    
    private let errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.setActionButtonTitle("Close")
        errorView.setActionButton(isEnabled: true)
        return errorView
    }()

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        setupLC()
        errorViewCloseButtonDidClick()
    }

    private func setupLC() {
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func errorViewCloseButtonDidClick() {
        errorView.actionButtonDidClickHandler = { [weak self] in
            self?.presenter?.dismiss()
        }
    }
    
}

//MARK: - Protocol Methods

extension ErrorViewViewController {
    
    func set(errorViewModel: ErrorViewModel) {
        errorView.configure(with: errorViewModel)
    }
    
}
