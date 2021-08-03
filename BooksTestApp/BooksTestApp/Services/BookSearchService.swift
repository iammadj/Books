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
    func getPhotos(_ result: @escaping ((Result<[Test], Error>) -> Void))
    
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
                ImageCacheManager.shared.cacheImages(with: urls) { hasError in
                    if !hasError {
                        result(.success(items))
                    }
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func getPhotos(_ result: @escaping ((Result<[Test], Error>) -> Void)) {
        apiManager.request(with: PhotosEndpoint.getAll) { res in
            result(self.jsonMapper.mapToResult(from: res, for: nil, type: [Test].self))
        }
    }
    
}


enum PhotosEndpoint: Endpoint {
    case getAll
    
    var url: String {
        switch self {
        case .getAll:
            return "https://jsonplaceholder.typicode.com/photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        }
    }
}
