//
//  BookSearchService.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import Alamofire
import Kingfisher


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
            let response = self.jsonMapper.mapToResult(from: res, for: "items", type: [Book].self)
            switch response {
            case .success(let items):
                let urls = items.compactMap { $0.thumbnailUrl }
                let smallUrls = items.compactMap { $0.smallThumbnailUrl }
                let flattenUrls = [urls, smallUrls].flatMap { $0 }
                ImageCacheManager.shared.cacheImages(with: flattenUrls) { hasError in
                    if !hasError {
                        result(.success(items))
                    }
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
}
