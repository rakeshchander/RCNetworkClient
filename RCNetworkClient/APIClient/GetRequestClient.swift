//
//  GetRequestClient.swift
//  Module_Framework
//
//  Created by Comviva on 12/02/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation

public protocol GETAPIRequest: APIRequest {

}

public extension GETAPIRequest {
    func execute(requestParams: [String:String],
                 onSuccessResponse: @escaping (ResponseType) -> Void,
                 onErrorResponse: @escaping (ErrorResponseType) -> Void,
                 onError: @escaping(APITimeError) -> Void) {

        var requestInterceptors : [RequestInterceptor] = []
        var responseInterceptors : [ResponseInterceptor] = []
        
        if let interceptors = self.interceptors {
            requestInterceptors = interceptors.requestInterceptors
            responseInterceptors = interceptors.responseInterceptors
        }
        
        var completeGetURLPath = self.endPoint
        
        for param in requestParams {
            if completeGetURLPath.contains("?") {
                completeGetURLPath.append("&\(param.key)=\(param.value)")
            } else {
                completeGetURLPath.append("?\(param.key)=\(param.value)")
            }
        }

        var request = URLRequest.init(url: URL.init(string: completeGetURLPath)!, cachePolicy: self.cachingPolicy, timeoutInterval: self.timeoutInterval)
        request.httpMethod = "GET"
        
        request.applyInterceptors(interceptors: requestInterceptors)
        
        self.networkClient.consumeRequest(request: request, onSuccess: { ( httpResponse, data) in

         self.handleResponse(httpResponse: httpResponse, data: data, responseInterceptors: responseInterceptors, onSuccessResponse: onSuccessResponse, onErrorResponse: onErrorResponse, onError: onError)
            
        }) { (error) in
            // API Consumption Failure
            //use message from string fil

            if (self.retryInterceptor?.errorCodes.contains(error.errorCodeInResponse) ?? false){
                self.retryInterceptor?.interceptor.retryRequest(onSuccess: {
                    self.execute(requestParams: requestParams, onSuccessResponse: onSuccessResponse, onErrorResponse: onErrorResponse, onError: onError)
                }, onError: onError)
            }
            else{
                self.handleGenericError(onError: onError, errorCode: error.errorCodeInResponse, errorDescription: error.localizedDescription)
            }

        }

    }
}
