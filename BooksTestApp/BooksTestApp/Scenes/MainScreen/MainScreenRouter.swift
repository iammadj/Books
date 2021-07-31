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

}


class MainScreenRouter: MainScreenRouterProtocol {
    
    weak var viewController: MainScreenEntryPoint?
    
    static func createModule() -> UIViewController? {
        let view: MainScreenViewProtocol = MainScreenViewController()
        let interactor: MainScreenInteractorProtocol = MainScreenInteractor()
        let router: MainScreenRouterProtocol = MainScreenRouter()
        let presenter: MainScreenPresenterProtocol = MainScreenPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view as? MainScreenEntryPoint
        
        return view as? MainScreenEntryPoint
    }
}
