//
//  MainScreenRouter.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import UIKit


typealias MainScreenEntryPoint = MainScreenViewProtocol & UIViewController


protocol MainScreenRouterProtocol: BaseRouterProtocol {
    
    var viewController: MainScreenEntryPoint? { get set }
    
    static func createModule() -> UIViewController?
    
    func presentErrorView(with errorViewModel: ErrorViewModel)
    func presentNetworkErrorView()

}


class MainScreenRouter: MainScreenRouterProtocol {
    
    weak var viewController: MainScreenEntryPoint?
    
    static func createModule() -> UIViewController? {
        let view: MainScreenViewProtocol = MainScreenViewController()
        let interactor: MainScreenInteractorProtocol = MainScreenInteractor()
        let presenter: MainScreenPresenterProtocol = MainScreenPresenter()
        let router: MainScreenRouterProtocol = MainScreenRouter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.viewController = view as? MainScreenEntryPoint
        
        return view as? MainScreenEntryPoint
    }
    
    func presentErrorView(with errorViewModel: ErrorViewModel) {
        guard let errorViewController = ErrorViewRouter.createModule(with: errorViewModel) else {
            return
        }
        errorViewController.modalTransitionStyle = .crossDissolve
        errorViewController.modalPresentationStyle = .overCurrentContext
        viewController?.present(errorViewController, animated: true, completion: nil)
    }
    
    func presentNetworkErrorView() {
        guard let networkErrorView = NetworkErrorRouter.createModule() else {
            return
        }
        networkErrorView.modalTransitionStyle = .crossDissolve
        networkErrorView.modalPresentationStyle = .fullScreen
        viewController?.present(networkErrorView, animated: true, completion: nil)
    }
    
}
