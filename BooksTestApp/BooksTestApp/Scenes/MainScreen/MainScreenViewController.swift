//
//  MainScreenViewController.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import UIKit


protocol MainScreenViewProtocol: AnyObject {

    var presenter: MainScreenPresenterProtocol?  { get set }
    
}


class MainScreenViewController: UIViewController, MainScreenViewProtocol {

	weak var presenter: MainScreenPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}
