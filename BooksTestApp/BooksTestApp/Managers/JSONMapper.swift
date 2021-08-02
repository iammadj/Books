//
//  JSONMapper.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation


class JSONMapper: JSONMapperProtocol {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.decoder.dateDecodingStrategy = .millisecondsSince1970
        
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
        throw FetchError.failed
    }
    
}
