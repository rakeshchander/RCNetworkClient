//
//  NetworkClient.swift
//  TwitterSample
//
//  Created by Comviva on 05/02/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import RCNetworkClient
import Alamofire

class AlamofireNetworkClient : NetworkDispatcher{
    
    
    func consumeRequest(request: URLRequest, onSuccess: @escaping (HTTPURLResponse, Data?) -> Void, onError: @escaping (APITimeError) -> Void) {
        
        Alamofire.request(request)
            .validate()
            .responseData { (response) in
                
                guard response.result.isSuccess else {
                    
                    let customError = APITimeError.init(response.result.error?.localizedDescription ?? "unexpectedError","\(response.response?.statusCode ?? -1)", response.data)
                    onError(customError)
                    return
                }
                
                guard let responseData = response.data else{
                    let customError = APITimeError.init("unexpectedError", "500", response.data)
                    onError(customError)
                    return
                }
                
                onSuccess(response.response!, responseData)
        }
        
    }
    
}

