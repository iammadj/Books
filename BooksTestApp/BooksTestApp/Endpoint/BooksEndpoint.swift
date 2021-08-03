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
            let query = queryString.lowercased().replacingOccurrences(of: " ", with: "+")
            return String(format: "%@%@", baseUrl, query)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBooks:
            return .get
        }
    }
    
}
