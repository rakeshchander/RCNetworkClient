//
//  UserFeedDataSource.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import RCNetworkClient

struct UserFeedAPI: GETAPIRequest {
    
    typealias ResponseType = [TweetDAO]
    
    typealias ErrorResponseType = RootErrorDAO
    
    var endPoint: String {
        return PlatformConstants.serverURL + PlatformConstants.userFeed
    }
    
}
