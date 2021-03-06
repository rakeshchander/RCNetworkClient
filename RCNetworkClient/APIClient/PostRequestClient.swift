//
//  PostRequestClient.swift
//  Module_Framework
//
//  Created by Comviva on 12/02/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation

public protocol POSTAPIRequest: APIRequest {
    associatedtype RequestBodyType: Encodable
}

public extension POSTAPIRequest {

    func execute(requestBody: Self.RequestBodyType,
                 onSuccessResponse: @escaping (ResponseType) -> Void,
                 onErrorResponse: @escaping (ErrorResponseType) -> Void,
                 onError: @escaping(APITimeError) -> Void) {

        // Validate Input Request Codable Object for mandatory Parameters

        do {

            var requestData: Data?

            if let stringBody = requestBody as? String {
                requestData = stringBody.data(using: .utf8)
            } else {
                let jsonEncoder = JSONEncoder()
                let encodedJson = try jsonEncoder.encode(requestBody)
                requestData = encodedJson
            }
            
            var requestInterceptors : [RequestInterceptor] = []
            var responseInterceptors : [ResponseInterceptor] = []
            
            if let interceptors = self.interceptors {
                requestInterceptors = interceptors.requestInterceptors
                responseInterceptors = interceptors.responseInterceptors
            }
            
            guard let requestURL = URL.init(string: self.endPoint) else {
                onError(APITimeError.init(errorCode: RCNetworkConstants.inValidRequestURL.rawValue, message: RCNetworkConstants.inValidRequestURL.rawValue))
                return
            }

            var request = URLRequest.init(url: requestURL, cachePolicy: self.cachingPolicy, timeoutInterval: self.timeoutInterval)
            request.httpBody = requestData
            request.httpMethod = "POST"
            
            request.applyInterceptors(interceptors: requestInterceptors)
            
            self.networkClient.consumeRequest(request: request, onSuccess: { ( httpResponse, data) in

                self.handleResponse(httpResponse: httpResponse, data: data, responseInterceptors: responseInterceptors, onSuccessResponse: onSuccessResponse, onErrorResponse: onErrorResponse, onError: onError)
                   
               }) { (error) in
                   // API Consumption Failure

                   if (self.retryInterceptor?.errorCodes.contains(error.errorCodeInResponse) ?? false){
                       self.retryInterceptor?.interceptor.retryRequest(onSuccess: {
                           self.execute(requestBody: requestBody, onSuccessResponse: onSuccessResponse, onErrorResponse: onErrorResponse, onError: onError)
                       }, onError: onError)
                   }
                   else{
                       self.handleGenericError(onError: onError, errorCode: error.errorCodeInResponse, errorDescription: error.localizedDescription)
                   }

               }
            
            

        } catch let error {
            // Request Codable Object - Failure for encoding
            self.handleGenericError(onError: onError,errorCode: RCNetworkConstants.inValidRequestBody.rawValue, errorDescription: error.localizedDescription)
            return
        }

    }

}
