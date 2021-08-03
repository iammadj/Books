//
//  UICollectionView+extensions.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 03/08/21.
//

import UIKit


extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ :T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reusableId)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableId, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableId)")
        }
        
        return cell
    }
    
}
