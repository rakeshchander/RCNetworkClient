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
                
                guard response.result.isSuccess, let httpResponse = response.response else {
                    
                    let customError = APITimeError.init(errorCode: "\(response.response?.statusCode ?? -1)",message: response.result.error?.localizedDescription ?? "unexpectedError", receivedResponse: response.data)
                    onError(customError)
                    return
                }
                
                guard let responseData = response.data else{
                    let customError = APITimeError.init(errorCode: "\(httpResponse.statusCode)", message: "unexpectedError", receivedResponse: response.data)
                    onError(customError)
                    return
                }
                
                onSuccess(httpResponse, responseData)
        }
        
    }
    
}
