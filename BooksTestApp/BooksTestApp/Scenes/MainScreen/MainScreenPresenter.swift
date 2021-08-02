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
    func viewDidLoad()
    func getItems(with queryString: String)
    func presentNetworkErrorView()
    
    // Interactor to Presenter
    func didFetchItems(with result: BookSearchResult)

}


class MainScreenPresenter: MainScreenPresenterProtocol {

    weak var view: MainScreenViewProtocol?
    var interactor: MainScreenInteractorProtocol?
    var router: MainScreenRouterProtocol?
    
    //MARK: - View to Presenter Methods
    
    func viewDidLoad() {
        setupView()
    }
    
    func getItems(with queryString: String) {
        setupView()
        interactor?.getItems(with: queryString)
    }
    
    func presentNetworkErrorView() {
        router?.presentNetworkErrorView()
    }
    
    //MARK: - Interactor to Presenter Methods
    
    func didFetchItems(with result: BookSearchResult) {
        switch result {
        case .success(let books):
            view?.updateViewWith(items: books)
            view?.reload()
            hideIndicatorView()
        case .failure(let error):
            view?.updateViewWithError()
            view?.reload()
            hideIndicatorView()
            presentErrorView(with: ErrorViewModel(title: "Ooops! Something went wrong", description: error.localizedDescription))
        }
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        view?.setAnimatingView(isHidden: false)
        view?.startAnimatingIndicatorView()
    }
    
    private func hideIndicatorView() {
        view?.stopAnimatingIndicatorView()
        view?.setAnimatingView(isHidden: true)
    }
    
    private func presentErrorView(with errorViewModel: ErrorViewModel) {
        router?.presentErrorView(with: errorViewModel)
    }

}
