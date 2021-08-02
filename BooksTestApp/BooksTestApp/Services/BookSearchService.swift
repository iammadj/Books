//
//  BookSearchService.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol BookSearchServiceProtocol {
    
    func getBooks(with queryString: String, result: @escaping (BookSearchResult) -> ())
    
}


class BookSearchService: BookSearchServiceProtocol {
    
    let apiManager: APIManagerProtocol
    let jsonMapper: JSONMapperProtocol
    
    init(apiManager: APIManagerProtocol = APIManager(), jsonMapper: JSONMapperProtocol = JSONMapper()) {
        self.apiManager = apiManager
        self.jsonMapper = jsonMapper
    }
    
    func getBooks(with queryString: String, result: @escaping (BookSearchResult) -> ()) {
        apiManager.request(with: BooksEndpoint.getBooks(queryString)) { res in
            result(self.jsonMapper.mapToResult(from: res, for: "items", type: [Book].self))
        }
    }
    
}
