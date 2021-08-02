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
    func getItems()
    
    // Interactor to Presenter
    func didFetchItems(with result: BookSearchResult)

}


class MainScreenPresenter: MainScreenPresenterProtocol {

    weak var view: MainScreenViewProtocol?
    var interactor: MainScreenInteractorProtocol?
    var router: MainScreenRouterProtocol?
    
    //MARK: - View to Presenter Methods
    
    func viewDidLoad() {
        startFetchingItems()
    }
    
    func getItems() {
        startFetchingItems()
    }
    
    //MARK: - Interactor to Presenter Methods
    
    func didFetchItems(with result: BookSearchResult) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            switch result {
            case .success(let books):
                self?.view?.updateViewWith(items: books)
                self?.view?.reload()
                self?.hideIndicatorView()
            case .failure(let error):
                self?.view?.updateViewWithError()
                self?.view?.reload()
                self?.hideIndicatorView()
                self?.presentErrorView(with: ErrorViewModel(title: "Ooops! Something went wrong", description: error.description))
            }
        }
    }
    
    //MARK: - Private Methods
    
    private func startFetchingItems() {
        view?.setReloadButton(isHidden: true)
        view?.setAnimatingView(isHidden: false)
        view?.startAnimatingIndicatorView()
        interactor?.getItems()
    }
    
    private func hideIndicatorView() {
        view?.stopAnimatingIndicatorView()
        view?.setAnimatingView(isHidden: true)
    }
    
    private func presentErrorView(with errorViewModel: ErrorViewModel) {
        router?.presentErrorView(with: errorViewModel, { [weak self] in
            self?.view?.setReloadButton(isHidden: false)
        })
    }

}
