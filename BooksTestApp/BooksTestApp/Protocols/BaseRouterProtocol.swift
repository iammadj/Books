//
//  BaseRouterProtocol.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 31/07/21.
//

import UIKit


typealias EmptyCompletion = (() -> Void)


protocol BaseRouterProtocol: AnyObject {
    
    func dismiss(viewController: UIViewController?, animated: Bool, completion: EmptyCompletion?)
    func pop(viewController: UIViewController?, animated: Bool)
    func close(viewController: UIViewController?, animated: Bool, completion: EmptyCompletion?)
    
}


extension BaseRouterProtocol {
    
    func dismiss(viewController: UIViewController?, animated: Bool = true, completion: EmptyCompletion? = nil) {
        viewController?.dismiss(animated: animated, completion: completion)
    }
    
    func pop(viewController: UIViewController?, animated: Bool = true) {
        viewController?.navigationController?.popViewController(animated: animated)
    }
    
    func close(viewController: UIViewController?, animated: Bool = true, completion: EmptyCompletion? = nil) {
        let isNotNavigationController = viewController?.navigationController == nil || viewController?.navigationController?.viewControllers.count == 1
        
        if isNotNavigationController {
            dismiss(viewController: viewController, animated: animated, completion: completion)
        } else {
            pop(viewController: viewController, animated: animated)
        }
    }
    
}
