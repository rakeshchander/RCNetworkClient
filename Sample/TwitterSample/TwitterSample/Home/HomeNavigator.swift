//
//  HomeNavigator.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import UIKit

protocol HomeFlowDelegate: TweetFlowDelegate {
    
}

class HomeNavigator : HomeFlowDelegate {
    
    let appDlgt = UIApplication.shared.delegate as? AppDelegate
    
    func startUserTweetsFlow(user: UserDAO) {
        let userFeedComponent = UserFeedComponent.init(user: user)
        let targetVC = UserFeedModule.getUserFeedViewController(component: userFeedComponent)
        
        (appDlgt?.window?.rootViewController as? UINavigationController)?.pushViewController(targetVC, animated: true)
        
    }
}

class UserFeedComponent : UserFeedDependency {
    let user : UserDAO
    
    init(user : UserDAO) {
        self.user = user
    }
    
    func getUserId() -> UserDAO {
        self.user
    }
    
}
