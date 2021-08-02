//
//  APIManager.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIManager: APIManagerProtocol {
    
    func request(with endpoint: Endpoint, result: @escaping (AFResult<APIResponseProtocol>) -> ()) {
        AF.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: endpoint.headers)
            .validate()
            .responseData { response in
                if let resp = response.response {
                    print(resp)
                }
                if let data = response.value {
                    print(JSON(data))
                }
                
                if let error = response.error {
                    result(.failure(error))
                    return
                    
                }
                                
                switch response.result {
                case .failure(let error):
                    result(.failure(error))
                case .success(let data):
                    let resp = APIResponse(response: response.response, result: data)
                    if let error = resp.error  {
                        result(.failure(error.asAFError(orFailWith: FetchError.parseError.description)))
                        return
                    }
                    result(.success(resp))
                }
        }
    }
    
}
