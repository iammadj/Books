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
    
    func presentErrorView(with errorViewModel: ErrorViewModel, _ completionHandler: @escaping EmptyCompletion)
    func pushToBookDetailsView(with item: Book)

}


class MainScreenRouter: MainScreenRouterProtocol {
    
    weak var viewController: MainScreenEntryPoint?
    
    static func createModule() -> UIViewController? {
        let view: MainScreenViewProtocol = MainScreenCollectionViewController()
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
    
    func presentErrorView(with errorViewModel: ErrorViewModel, _ completionHandler: @escaping EmptyCompletion) {
        guard let errorViewController = ErrorViewRouter.createModule(with: errorViewModel, completionHandler) else {
            return
        }
        errorViewController.modalTransitionStyle = .crossDissolve
        errorViewController.modalPresentationStyle = .overCurrentContext
        viewController?.present(errorViewController, animated: true, completion: nil)
    }
    
    func pushToBookDetailsView(with item: Book) {
        guard let bookDetailsView = BookDetailsRouter.createModule(with: item) else {
            return
        }
        viewController?.navigationController?.pushViewController(bookDetailsView, animated: true)
    }
    
}
