//
//  MainScreenEntity.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import Foundation


struct Book: Decodable {
    
    private let volumeInfo: VolumeInfo

    var title: String { volumeInfo.title }
    var authors: String { volumeInfo.authors.joined(separator: ", ") }
    var description: String { volumeInfo.description }
    var smallThumbnailUrl: URL? { volumeInfo.imageLinks?.smallThumbnail }
    var thumbnailUrl: URL? { volumeInfo.imageLinks?.thumbnail }

}


struct VolumeInfo: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case description
        case imageLinks
    }
    
    let title: String
    let authors: [String]
    let description: String
    let imageLinks: ImageLinks?
    
    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.title = (try? map.decode(String.self, forKey: .title)) ?? ""
        self.authors = (try? map.decode([String].self, forKey: .authors)) ?? []
        self.description = (try? map.decode(String.self, forKey: .description)) ?? ""
        self.imageLinks = try? map.decode(ImageLinks.self, forKey: .imageLinks)
    }
    
}


struct ImageLinks: Decodable {
    
    let smallThumbnail: URL
    let thumbnail: URL
    
}
