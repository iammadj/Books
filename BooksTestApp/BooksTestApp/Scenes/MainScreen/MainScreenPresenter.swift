//
//  MainScreenPresenter.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import UIKit


protocol MainScreenPresenterProtocol: AnyObject {
    
    var view: MainScreenViewProtocol? { get set }
    var interactor: MainScreenInteractorProtocol? { get set }
    var router: MainScreenRouterProtocol? { get set }

}


class MainScreenPresenter: MainScreenPresenterProtocol {

    weak var view: MainScreenViewProtocol?
    var interactor: MainScreenInteractorProtocol?
    var router: MainScreenRouterProtocol?

    init(view: MainScreenViewProtocol, interactor: MainScreenInteractorProtocol?, router: MainScreenRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

}
