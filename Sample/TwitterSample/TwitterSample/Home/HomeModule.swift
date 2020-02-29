//
//  HomeModule.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import UIKit
import RCNetworkClient

class HomeModule {
    
    
    static func getHomeViewController(delegate: HomeFlowDelegate? = nil) -> HomeViewController {
        
        let targetVC: HomeViewController
        
        targetVC = HomeViewController.init(nibName: "HomeViewController", bundle: Bundle.init(for: HomeModule.self) )
        
        targetVC.viewModel = getHomeViewModel(delegate: delegate)
        
        return targetVC
        
        
    }
    
    static func getHomeViewModel(delegate: HomeFlowDelegate? = nil) -> HomeViewModel {
        
        var flowDelegate = delegate
        
        if flowDelegate == nil {
            flowDelegate = HomeNavigator()
        }
        
        let dataSource = HomeDataSource.init()
        let viewModel = HomeViewModel.init(delegate: flowDelegate, dataSource: dataSource)
        
        return viewModel
    }
    
}
