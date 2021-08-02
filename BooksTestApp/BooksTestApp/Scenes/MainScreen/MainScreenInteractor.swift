//
//  MainScreenInteractor.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import UIKit


protocol MainScreenInteractorProtocol: AnyObject {

    var presenter: MainScreenPresenterProtocol?  { get set }
    
    func getItems()
    
}


class MainScreenInteractor: MainScreenInteractorProtocol {

    var presenter: MainScreenPresenterProtocol?
    
    private let books: [Book] = [
//        .init(imageName: "book1", title: "Charles Chaplin"),
//        .init(imageName: "book2", title: "Darwin"),
//        .init(imageName: "book3", title: "Robinson Cruso"),
//        .init(imageName: "book4", title: "Marvel"),
//        .init(imageName: "book5", title: "Cars"),
//        .init(imageName: "book6", title: "About life"),
//        .init(imageName: "book7", title: "Wild nature")
    ]
    
    func getItems() {
        let result: BookResulType = books.isEmpty ? .failure(FetchError.failed): .success(books)
        presenter?.didFetchItems(with: result)
    }
    
}
