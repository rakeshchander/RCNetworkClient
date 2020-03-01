//
//  HomeDataSource.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import RCNetworkClient

struct HomeFeedAPI: GETAPIRequest {
    
    typealias ResponseType = HomeResponseDAO
    
    typealias ErrorResponseType = AppTokenErrorDAO
    
    var endPoint: String {
        return PlatformConstants.serverURL + PlatformConstants.homeFeed
    }
    
}
