//
//  SearchControllerFactory.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 01/08/21.
//

import UIKit


class SearchControllerFactory {
    
    static func create(with delegate: (UISearchResultsUpdating & UISearchControllerDelegate),
                       placeholder: String) -> UISearchController {
        let searchController: UISearchController =  {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = delegate
            searchController.delegate = delegate
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.obscuresBackgroundDuringPresentation = false
//            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.searchBarStyle = .minimal
            searchController.searchBar.isTranslucent = false
//            searchController.searchBar.backgroundColor = .background // if the app will have dark mode, here we can set correct bg color
            searchController.searchBar.placeholder = placeholder
            searchController.searchBar.setValue("Cancel", forKey:"cancelButtonText")
            searchController.searchBar.tintColor = .link
            return searchController
        }()
        return searchController
    }
    
}
