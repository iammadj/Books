//
//  NetworkErrorRouter.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


typealias NetworkErrorEntryPoint = NetworkErrorViewProtocol & UIViewController


protocol NetworkErrorRouterProtocol: BaseRouterProtocol {
    
    var viewController: NetworkErrorEntryPoint? { get set }
    
    static func createModule() -> UIViewController?

}


class NetworkErrorRouter: NetworkErrorRouterProtocol {
    
    weak var viewController: NetworkErrorEntryPoint?
    
    static func createModule() -> UIViewController? {
        let view: NetworkErrorViewProtocol = NetworkErrorViewController()
        let interactor: NetworkErrorInteractorProtocol = NetworkErrorInteractor()
        let presenter: NetworkErrorPresenterProtocol = NetworkErrorPresenter()
        let router: NetworkErrorRouterProtocol = NetworkErrorRouter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.viewController = view as? NetworkErrorEntryPoint
        
        return view as? NetworkErrorEntryPoint
    }
}
