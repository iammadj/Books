//
//  MainScreenInteractor.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import UIKit


protocol MainScreenInteractorProtocol: AnyObject {

    var presenter: MainScreenPresenterProtocol?  { get set }
    
    func getItems(with queryString: String)
    
}


class MainScreenInteractor: MainScreenInteractorProtocol {

    var presenter: MainScreenPresenterProtocol?
    
    let bookService: BookSearchServiceProtocol = BookSearchService()
    
    func getItems(with queryString: String) {
        bookService.getBooks(with: queryString) { [weak self] result in
            self?.presenter?.didFetchItems(with: result)
        }
    }
    
}
