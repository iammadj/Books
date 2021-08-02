//
//  FetchError.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation


enum FetchError: Error {
    case failed
    
    var description: String {
        switch self {
        case .failed:
            return "Sorry! Could not fetch data."
        }
    }
}
