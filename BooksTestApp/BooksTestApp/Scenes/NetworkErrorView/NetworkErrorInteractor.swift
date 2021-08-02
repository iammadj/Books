//
//  NetworkErrorInteractor.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol NetworkErrorInteractorProtocol: AnyObject {

    var presenter: NetworkErrorPresenterProtocol?  { get set }
    
}


class NetworkErrorInteractor: NetworkErrorInteractorProtocol {

    var presenter: NetworkErrorPresenterProtocol?
    
}
