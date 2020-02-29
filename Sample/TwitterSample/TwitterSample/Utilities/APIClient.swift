//
//  APIClient.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import RCNetworkClient

public extension APIRequest {
    var retryInterceptor : (interceptor : RetryInterceptor, errorCodes : [String])?{
        get{
            (AppTokenRefreshWrapper(), ["401", "400"])
        }
    }
    
    var interceptors : (requestInterceptors: [RequestInterceptor],responseInterceptors:  [ResponseInterceptor])? {
        get {
            ([CommonRequestHeaderInterceptors()], [])
        }
    }
    
    var networkClient : NetworkDispatcher {
        get {
            AlamofireNetworkClient()
        }
    }
    
    var mimeType: String {
        get{
            ""
        }
        
    }
    
    var timeoutInterval : TimeInterval {
        get{
            30
        }
    }
    
    var cachingPolicy : URLRequest.CachePolicy {
        get{
            URLRequest.CachePolicy.useProtocolCachePolicy
        }
        
    }
    
}
