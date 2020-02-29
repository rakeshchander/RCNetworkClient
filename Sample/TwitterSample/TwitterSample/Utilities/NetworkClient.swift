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
                    
                    let customError = APITimeError.init(response.result.error?.localizedDescription ?? "unexpectedError","\(response.response?.statusCode ?? -1)", response.data)
                    onError(customError)
                    return
                }
                
                guard let responseData = response.data else{
                    let customError = APITimeError.init("unexpectedError", "\(httpResponse.statusCode)", response.data)
                    onError(customError)
                    return
                }
                
                onSuccess(httpResponse, responseData)
        }
        
    }
    
}

public class CoreNetworkClient1: NSObject, NetworkDispatcher {
    public func consumeRequest(request: URLRequest, onSuccess: @escaping (HTTPURLResponse, Data?) -> Void, onError: @escaping (APITimeError) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let customError = APITimeError.init("unexpectedError", "-1", data)
                onError(customError)
                return
            }
            
            guard let responseError = error else {
                onSuccess(httpResponse , data)
                return
            }

            let customError = APITimeError.init(responseError.localizedDescription, "\(httpResponse.statusCode)")
            
            onError(customError)

        }

        task.resume()

    }
}

