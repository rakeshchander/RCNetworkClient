//
//  APIInterface.swift
//  NBKMerchantApp
//
//  Created by Comviva on 15/03/19.
//  Copyright © 2019 Comviva. All rights reserved.
//

import Foundation

public class CoreNetworkClient: NSObject, NetworkDispatcher {
    public func consumeRequest(request: URLRequest, onSuccess: @escaping (HTTPURLResponse, Data) -> Void, onError: @escaping (APITimeError) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let customError = APITimeError.init(errorCode: "-1", message: "unexpectedError", receivedResponse: data)
                onError(customError)
                return
            }
            
            guard let responseData = data else {
                
                guard let responseError = error else {
                    let customError = APITimeError.init(errorCode: "\(httpResponse.statusCode)", message: "unexpectedError", receivedResponse: data)
                    onError(customError)
                    return
                }
                
                let customError = APITimeError.init(errorCode: "\(httpResponse.statusCode)", message: responseError.localizedDescription)
                
                onError(customError)
                
                return
                
            }
            
            
            onSuccess(httpResponse, responseData)
            

        }

        task.resume()

    }
}
