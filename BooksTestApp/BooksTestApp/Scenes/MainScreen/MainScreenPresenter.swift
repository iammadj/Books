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
    
    // View to Presenter
    func getItems(with queryString: String)
    func didSelect(item: Book)
    
    // Interactor to Presenter
    func didFetchItems(with result: BookSearchResult)

}


class MainScreenPresenter: MainScreenPresenterProtocol {

    weak var view: MainScreenViewProtocol?
    var interactor: MainScreenInteractorProtocol?
    var router: MainScreenRouterProtocol?
    
    //MARK: - View to Presenter Methods
    
    func getItems(with queryString: String) {
        view?.startAnimatingIndicatorView()
        interactor?.getItems(with: queryString)
    }
    
    func didSelect(item: Book) {
        router?.pushToBookDetailsView(with: item)
    }
    
    //MARK: - Interactor to Presenter Methods
    
    func didFetchItems(with result: BookSearchResult) {
        switch result {
        case .success(let books):
            view?.updateViewWith(items: books)
            view?.reload()
            view?.stopAnimatingIndicatorView()
        case .failure:
            view?.stopAnimatingIndicatorView()
            view?.updateViewWithError()
            view?.reload()
            let errorViewModel = ErrorViewModel(title: Constants.errorTitle, description: Constants.responseErrorDescription)
            router?.presentErrorView(with: errorViewModel, { [weak self] in
                print("Dismissed error view")
                self?.view?.updateViewWith(items: [])
                self?.view?.reload()
            })
        }
    }

}
