//
//  APIManagerProtocol.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import Alamofire


protocol APIManagerProtocol {
    
    func request(with endpoint: Endpoint, result: @escaping (AFResult<APIResponseProtocol>) -> ())
    
}
