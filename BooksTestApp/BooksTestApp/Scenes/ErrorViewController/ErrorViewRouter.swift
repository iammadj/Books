//
//  ErrorViewRouter.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


typealias ErrorViewEntryPoint = ErrorViewViewProtocol & UIViewController


protocol ErrorViewRouterProtocol: BaseRouterProtocol {
    
    var viewController: ErrorViewEntryPoint? { get set }
    
    static func createModule(with errorViewModel: ErrorViewModel, _ completionHandler: @escaping EmptyCompletion) -> UIViewController?

}


class ErrorViewRouter: ErrorViewRouterProtocol {
    
    weak var viewController: ErrorViewEntryPoint?
    
    static func createModule(with errorViewModel: ErrorViewModel, _ completionHandler: @escaping EmptyCompletion) -> UIViewController? {
        let view: ErrorViewViewProtocol = ErrorViewViewController()
        let interactor: ErrorViewInteractorProtocol = ErrorViewInteractor()
        let presenter: ErrorViewPresenterProtocol = ErrorViewPresenter(with: errorViewModel, completionHandler)
        let router: ErrorViewRouterProtocol = ErrorViewRouter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.viewController = view as? ErrorViewEntryPoint
        
        return view as? ErrorViewEntryPoint
    }
}
