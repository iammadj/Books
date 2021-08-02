//
//  NetworkErrorPresenter.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol NetworkErrorPresenterProtocol: AnyObject {
    
    var view: NetworkErrorViewProtocol? { get set }
    var interactor: NetworkErrorInteractorProtocol? { get set }
    var router: NetworkErrorRouterProtocol? { get set }

    // View to Presenter
    func viewDidLoad()
    func dismiss()
    
}


class NetworkErrorPresenter: NetworkErrorPresenterProtocol {

    weak var view: NetworkErrorViewProtocol?
    var interactor: NetworkErrorInteractorProtocol?
    var router: NetworkErrorRouterProtocol?
    
    var viewController: UIViewController? { view as? UIViewController }
    
    func viewDidLoad() {
        view?.set(errorViewModel: ErrorViewModel(title: "Ooops! Something went wrong", description: "Your device is not connected to internet. Retry again."))
    }

    func dismiss() {
        router?.close(viewController: viewController, animated: true, completion: nil)
    }
    
}
