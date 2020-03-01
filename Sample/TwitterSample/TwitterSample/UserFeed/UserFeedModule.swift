//
//  UserFeedModule.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import UIKit
import RCNetworkClient

protocol UserFeedDependency {
    func getUserId() -> UserDAO
}

class UserFeedModule {
    
    
    static func getUserFeedViewController(component: UserFeedDependency) -> UserFeedViewController {
        
        let targetVC: UserFeedViewController
        
        targetVC = UserFeedViewController.init(nibName: "UserFeedViewController", bundle: Bundle.init(for: UserFeedModule.self) )
        
        targetVC.viewModel = getUserFeedViewModel(component: component)
        
        return targetVC
        
        
    }
    
    static func getUserFeedViewModel(component: UserFeedDependency) -> UserFeedViewModel {
        
        let viewModel = UserFeedViewModel.init(twitterUser: component.getUserId())
        
        return viewModel
    }
    
}

