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

    // View to Presenter
    func viewDidLoad()
    
}


class BookDetailsPresenter: BookDetailsPresenterProtocol {

    weak var view: BookDetailsViewProtocol?
    var interactor: BookDetailsInteractorProtocol?
    var router: BookDetailsRouterProtocol?
    
    private let item: Book

    init(with item: Book) {
        self.item = item
    }
    
    func viewDidLoad() {
        view?.updateView(with: item)
    }
    
}
