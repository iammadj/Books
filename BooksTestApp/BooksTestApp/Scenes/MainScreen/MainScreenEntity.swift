//
//  MainScreenEntity.swift
//  BooksTestApp
//
//  Created Majit Uteniyazov on 31/07/21.
//

import Foundation


struct Book: Decodable {
    
    let volumeInfo: VolumeInfo

}


struct VolumeInfo: Decodable {
    
    let title: String
    let authors: [String]
    let description: String?
    let imageLinks: ImageLinks
    
}


struct ImageLinks: Decodable {
    
    let smallThumbnail: URL
    let thumbnail: URL
    
}
