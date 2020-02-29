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
    
    
    func consumeRequest(request: URLRequest, onSuccess: @escaping (HTTPURLResponse, Data) -> Void, onError: @escaping (APITimeError) -> Void) {
        
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

public class CoreNetworkClient1: NSObject, NetworkDispatcher {
    public func consumeRequest(request: URLRequest, onSuccess: @escaping (HTTPURLResponse, Data) -> Void, onError: @escaping (APITimeError) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let customError = APITimeError.init(errorCode: "-1", message: "unexpectedError", receivedResponse: data)
                onError(customError)
                return
            }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299  {
                onSuccess(httpResponse, data!)
            } else {
                
                guard let responseError = error else {
                    let customError = APITimeError.init(errorCode: "\(httpResponse.statusCode)", message: "unexpectedError", receivedResponse: data)
                    onError(customError)
                    return
                }
                
                let customError = APITimeError.init(errorCode: "\(httpResponse.statusCode)", message: responseError.localizedDescription)
                
                onError(customError)
            }
            

        }

        task.resume()

    }
}
