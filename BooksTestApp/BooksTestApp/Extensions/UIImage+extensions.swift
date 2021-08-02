//
//  UIImage+extensions.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import UIKit


extension UIImage {
    
    func getCropRatio() -> CGFloat {
        CGFloat(self.size.width / self.size.height)
    }
    
}
