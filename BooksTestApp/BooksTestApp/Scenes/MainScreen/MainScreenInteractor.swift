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
//        let result: BookSearchResult = books.isEmpty ? .failure(FetchError.failed): .success(books)
//        presenter?.didFetchItems(with: result)
        bookService.getBooks(with: queryString) { [weak self] res in
            self?.presenter?.didFetchItems(with: res)
        }
    }
    
}
