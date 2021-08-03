//
//  Reusable+ReusableIdentifier.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 04/08/21.
//

import UIKit


protocol Reusable {
    
    static var reusableId: String { get }
    
}


extension UICollectionViewCell: Reusable {
    
    static var reusableId: String { String(describing: self) }
    
}


extension UITableViewCell: Reusable {
    
    static var reusableId: String { String(describing: self) }
    
}
