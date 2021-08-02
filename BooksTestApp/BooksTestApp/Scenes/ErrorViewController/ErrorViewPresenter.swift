//
//  ErrorViewPresenter.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol ErrorViewPresenterProtocol: AnyObject {
    
    var view: ErrorViewViewProtocol? { get set }
    var interactor: ErrorViewInteractorProtocol? { get set }
    var router: ErrorViewRouterProtocol? { get set }
    
    func viewDidLoad()
    func dismiss()

}


class ErrorViewPresenter: ErrorViewPresenterProtocol {

    weak var view: ErrorViewViewProtocol?
    var interactor: ErrorViewInteractorProtocol?
    var router: ErrorViewRouterProtocol?
    
    private var viewController: UIViewController? { view as? UIViewController }
    
    private let errorViewModel: ErrorViewModel
    private let completionHandler: EmptyCompletion
    
    init(errorViewModel: ErrorViewModel, completionHandler: @escaping EmptyCompletion) {
        self.errorViewModel = errorViewModel
        self.completionHandler = completionHandler
    }
    
    func viewDidLoad() {
        view?.set(errorViewModel: errorViewModel)
    }
    
    func dismiss() {
        router?.dismiss(viewController: viewController, animated: true, completion: { [weak self] in
            self?.completionHandler()
        })
    }

}
