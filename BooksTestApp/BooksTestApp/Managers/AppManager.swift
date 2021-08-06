//
//  AppManager.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 06/08/21.
//

import Foundation


class AppManager {
    
    enum AppTargetType {
        case development
        case production
    }
    
    static var target: AppTargetType = .development
    
    class func setup() {
        #if DEVELOPMENT
            target = .development
            // API, tokens setup
        #else
            target = .production
            // API, tokens setup
        #endif
    }
    
}
