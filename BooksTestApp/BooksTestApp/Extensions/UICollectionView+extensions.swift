//
//  UICollectionView+extensions.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 03/08/21.
//

import UIKit


protocol Reusable {
    
    static var reusableIdentifier: String { get }
    
}


extension UICollectionViewCell: Reusable {
    
    static var reusableIdentifier: String { String(describing: self) }
    
}


extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ :T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        
        return cell
    }
    
}
