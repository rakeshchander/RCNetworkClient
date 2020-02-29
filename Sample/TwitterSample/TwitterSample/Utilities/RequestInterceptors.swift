//
//  RequestInterceptors.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import RCNetworkClient

class CommonRequestHeaderInterceptors : RequestInterceptor {
    
    func interceptRequest(request: inout URLRequest) -> URLRequest {
        
        request.addValue("Bearer " + (APIDataManager.appToken ?? ""), forHTTPHeaderField: "Authorization")
        
        return request
    }
}
