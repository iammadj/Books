//
//  ErrorViewInteractor.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol ErrorViewInteractorProtocol: AnyObject {

    var presenter: ErrorViewPresenterProtocol?  { get set }
    
}


class ErrorViewInteractor: ErrorViewInteractorProtocol {

    var presenter: ErrorViewPresenterProtocol?
    
}
