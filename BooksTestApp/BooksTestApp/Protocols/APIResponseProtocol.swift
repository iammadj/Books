//
//  APIResponseProtocol.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import SwiftyJSON


protocol APIResponseProtocol {
    
    var response: HTTPURLResponse? { get }
    var result: Data?  { get }
    
    func body(for key: String?) -> Any?
    
}


extension APIResponseProtocol {
    
    func body(for key: String?) -> Any? {
        guard let result = result else {
            return nil
        }
    
        if let key = key {
            return JSON(result)[key].rawValue
        }
        
        return JSON(result).rawValue
    }
    
    func JSONBody() -> JSON? {
        guard let result = result else {
            return nil
        }
        return JSON(result)["result"]
    }
    
    var isHasError: Bool {
        guard let result = result else {
            return false
        }
        return JSON(result)["error"].exists()
    }
    
    var error: Error? {
        guard isHasError else {
            return nil
        }
        
        guard let result = result else {
            return nil
        }
        
        let json = JSON(result)
        let jsonError = json["error"]
        return jsonError.error
    }
    
}
