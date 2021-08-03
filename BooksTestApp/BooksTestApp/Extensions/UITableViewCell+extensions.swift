//
//  UITableViewCell+extensions.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 04/08/21.
//

import UIKit


extension UITableView {
    
    func register<T: UITableViewCell>(_ :T.Type) {
        register(T.self, forCellReuseIdentifier: T.reusableId)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableId, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableId)")
        }
        
        return cell
    }
    
}
