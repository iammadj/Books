//
//  JSONMapper.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import Alamofire


protocol JSONMapperProtocol {
    
    func mapToObject<T: Decodable>(from json: Any, type: T.Type) throws -> T
    func mapToObject<T: Decodable>(from data: Data, type: T.Type) throws -> T
    func mapToResult<T: Decodable>(from result: AFResult<APIResponseProtocol>, for key: String?, type: T.Type) -> Result<T, Error>
    
}


class JSONMapper: JSONMapperProtocol {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.decoder.dateDecodingStrategy = .millisecondsSince1970
        
    }
    
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
    
    func mapToObject<T: Decodable>(from json: Any, type: T.Type) throws -> T  {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try mapToObject(from: jsonData, type: type)
            return object
        }  catch {
            print(error.localizedDescription)
        }
        throw FetchError.parseError
    }
    
    func mapToObject<T: Decodable>(from data: Data, type: T.Type) throws -> T {
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch DecodingError.dataCorrupted(let context) {
            print(context.debugDescription)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("\(key.stringValue) was not found, \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("\(type) was expected, \(context.debugDescription) | \(context.codingPath)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("no value was found for \(type), \(context.debugDescription)")
        } catch {
            print("Unknown error")
        }
        throw FetchError.failedMapToObject
    }
    
}
