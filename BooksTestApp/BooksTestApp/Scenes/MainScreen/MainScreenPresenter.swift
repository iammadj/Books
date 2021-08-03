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
    func presentNetworkErrorView()
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
    
    func presentNetworkErrorView() {
        router?.presentNetworkErrorView()
    }
    
    func didSelect(item: Book) {
        
    }
    
    //MARK: - Interactor to Presenter Methods
    
    func didFetchItems(with result: BookSearchResult) {
        switch result {
        case .success(let books):
            view?.updateViewWith(items: books)
            view?.reload()
            view?.stopAnimatingIndicatorView()
        case .failure(let error):
            view?.updateViewWithError()
            view?.reload()
            view?.stopAnimatingIndicatorView()
            presentErrorView(with: ErrorViewModel(title: "Ooops! Something went wrong", description: error.localizedDescription))
        }
    }
    
    //MARK: - Private Methods
    
    private func presentErrorView(with errorViewModel: ErrorViewModel) {
        router?.presentErrorView(with: errorViewModel)
    }

}
