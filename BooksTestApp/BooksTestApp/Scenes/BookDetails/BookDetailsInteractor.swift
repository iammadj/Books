//
//  BookDetailsInteractor.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol BookDetailsInteractorProtocol: AnyObject {

    var presenter: BookDetailsPresenterProtocol?  { get set }
    
    func getBookImage(with url: URL?)
    
}


class BookDetailsInteractor: BookDetailsInteractorProtocol {

    var presenter: BookDetailsPresenterProtocol?
    
    func getBookImage(with url: URL?) {
        
    }
    
}
