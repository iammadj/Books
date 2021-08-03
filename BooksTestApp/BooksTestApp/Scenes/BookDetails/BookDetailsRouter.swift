//
//  BookDetailsRouter.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


typealias BookDetailsEntryPoint = BookDetailsViewProtocol & UIViewController


protocol BookDetailsRouterProtocol: BaseRouterProtocol {
    
    var viewController: BookDetailsEntryPoint? { get set }
    
    static func createModule(with item: Book) -> UIViewController?

}


class BookDetailsRouter: BookDetailsRouterProtocol {
    
    weak var viewController: BookDetailsEntryPoint?
    
    static func createModule(with item: Book) -> UIViewController? {
        let view: BookDetailsViewProtocol = BookDetailsViewController()
        let interactor: BookDetailsInteractorProtocol = BookDetailsInteractor()
        let presenter: BookDetailsPresenterProtocol = BookDetailsPresenter(with: item)
        let router: BookDetailsRouterProtocol = BookDetailsRouter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.viewController = view as? BookDetailsEntryPoint
        
        return view as? BookDetailsEntryPoint
    }
}
