//
//  FetchError.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation


enum FetchError: Error {
    case failed
    case emptyData
    case parseError
    
    var description: String {
        switch self {
        case .failed:
            return "Sorry! Could not fetch data."
        case .emptyData:
            return "There is no any data."
        case .parseError:
            return "Found error while parsing data."
        }
    }
}
