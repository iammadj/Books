//
//  BooksEndpoint.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import Alamofire


enum BooksEndpoint: Endpoint {
    
    case getBooks(String)
    
    var url: String {
        switch self {
        case .getBooks(let queryString):
            return String(format: "%@%@", baseUrl, queryString)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBooks:
            return .get
        }
    }
    
}
