//
//  Constants.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation

// MARK: - Typealiases

typealias EmptyCompletion = (() -> ())
typealias BookSearchResult = Result<[Book], FetchError>


//MARK: - Constants

class Constants {
    
    static let baseUrl = "https://www.googleapis.com/books/v1/volumes?q="
    
}
