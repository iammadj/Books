//
//  BookDetailsPresenter.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol BookDetailsPresenterProtocol: AnyObject {
    
    var view: BookDetailsViewProtocol? { get set }
    var interactor: BookDetailsInteractorProtocol? { get set }
    var router: BookDetailsRouterProtocol? { get set }

}


class BookDetailsPresenter: BookDetailsPresenterProtocol {

    weak var view: BookDetailsViewProtocol?
    var interactor: BookDetailsInteractorProtocol?
    var router: BookDetailsRouterProtocol?

}
