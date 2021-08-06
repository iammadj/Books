//
//  FetchError.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation


enum FetchError: Error {
    case failedMapToObject
    case emptyData
    case parseError
    
    var description: String {
        switch self {
        case .failedMapToObject:
            return "Sorry! Could not fetch data, because of something is wrong with mapping to Object."
        case .emptyData:
            return "There is no any data."
        case .parseError:
            return "Found error while parsing data."
        }
    }
}
