//
//  MainScreenInteractor.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import UIKit


protocol MainScreenInteractorProtocol: AnyObject {

    var presenter: MainScreenPresenterProtocol?  { get set }
    
}


class MainScreenInteractor: MainScreenInteractorProtocol {

    weak var presenter: MainScreenPresenterProtocol?
    
}
