//
//  File.swift
//  straiberry
//
//  Created by Behnam on 20.06.22.
//



import Foundation

import UIKit

public protocol Coordinator: AnyObject {
    // Presenter is viewController OR navigationController another viewController's presented upon this ...
     var presenter: UINavigationController { get set }
    
    // Coordinator entry point
     func start()
}

extension Coordinator {
    
    public func navigate(to viewController: UIViewController, with presentationStyle: navigationStyle, animated: Bool = true) {
        switch presentationStyle {
        case .present:
            presenter.present(viewController, animated: animated, completion: nil)
            break
        case .push:
            presenter.pushViewController(viewController, animated: animated)
            break
        default:
            break
        }

        
    }
    
}

public enum navigationStyle {
    case present
    case push
    case fade
    case root
}
