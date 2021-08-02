//
//  NetworkReachabilityHelper.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 02/08/21.
//

import Foundation
import Alamofire


class NetworkReachabilityHelper {

    static let sharedInstance = NetworkReachabilityManager()
    
    static var isConnectedToInternet: Bool { sharedInstance?.isReachable ?? false }
    
}
