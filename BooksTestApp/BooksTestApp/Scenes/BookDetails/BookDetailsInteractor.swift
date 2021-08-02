//
//  BookDetailsInteractor.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol BookDetailsInteractorProtocol: AnyObject {

    var presenter: BookDetailsPresenterProtocol?  { get set }
    
}


class BookDetailsInteractor: BookDetailsInteractorProtocol {

    var presenter: BookDetailsPresenterProtocol?
    
}
