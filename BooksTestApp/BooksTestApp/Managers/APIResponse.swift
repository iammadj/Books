//
//  APIResponse.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation


struct APIResponse: APIResponseProtocol {
    
    var response: HTTPURLResponse?
    var result: Data?
    
}
