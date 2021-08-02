//
//  Endpoint.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import Alamofire


protocol Endpoint {
    
    var url: String { get }
    
    var method: Alamofire.HTTPMethod { get }
        
    var parameters: [String: Any]? { get }
    
    var headers: HTTPHeaders? { get }
    
    var encoding: Alamofire.ParameterEncoding { get }
    
    var baseUrl: String { get }

}

extension Endpoint {
    
    var parameters: [String: Any]? { nil }
    
    var headers: HTTPHeaders? { nil }
    
    var encoding: Alamofire.ParameterEncoding { JSONEncoding.default }
    
    var baseUrl: String { Constants.baseUrl }

}
