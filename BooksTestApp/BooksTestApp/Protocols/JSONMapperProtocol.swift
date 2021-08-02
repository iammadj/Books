//
//  JSONMapperProtocol.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import Alamofire


protocol JSONMapperProtocol {
    
    func mapToObject<T: Decodable>(from json: Any, type: T.Type) throws -> T
    func mapToObject<T: Decodable>(from data: Data, type: T.Type) throws -> T
    
}

extension JSONMapperProtocol {
    
    func mapToResult<T: Decodable>(from result: AFResult<APIResponseProtocol>, for key: String?, type: T.Type) -> Result<T, Error> {
        switch result {
        case .success(let response):
            guard let bodyData = response.body(for: key) else {
                return Result.failure(FetchError.parseError)
            }
            
            do {
                let object = try self.mapToObject(from: bodyData, type: type)
                return Result.success(object)
            } catch let error  {
                return Result.failure(error)
            }
        case .failure(let error):
            return Result.failure(error)
        }
    }
    
}
