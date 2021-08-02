//
//  BookDetailsViewController.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 02/08/21.
//

import UIKit


protocol BookDetailsViewProtocol: AnyObject {

    var presenter: BookDetailsPresenterProtocol?  { get set }
    
}


class BookDetailsViewController: UIViewController, BookDetailsViewProtocol {

	var presenter: BookDetailsPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
    }

}
