//
//  APIClient.swift
//  iOS_Platform_Library
//
//  Created by Comviva on 10/06/19.
//  Copyright © 2019 Comviva. All rights reserved.
//

import Foundation

public protocol APIRequest {
    associatedtype ResponseType: Decodable
    associatedtype ErrorResponseType: Decodable
    var interceptors : (requestInterceptors: [RequestInterceptor], responseInterceptors: [ResponseInterceptor])? {get}
    var retryInterceptor: (interceptor : RetryInterceptor, errorCodes : [String])? {get}
    var endPoint: String {get}
    var mimeType: String {get}
    var networkClient: NetworkDispatcher {get}
    
    var timeoutInterval : TimeInterval {get}
    var cachingPolicy : URLRequest.CachePolicy {get}
}

extension APIRequest {
    
    
    func handleResponse(httpResponse : HTTPURLResponse,
                        data : Data?,
                        responseInterceptors : [ResponseInterceptor],
                        onSuccessResponse: @escaping (ResponseType) -> Void,
                        onErrorResponse: @escaping (ErrorResponseType) -> Void,
                        onError: @escaping(APITimeError) -> Void){
        
        var response = Response.init(httpResponse: httpResponse, data: data)
        response.applyInterceptors(interceptors: responseInterceptors)
        
        guard let responseData = response.data else {
            self.handleGenericError(onError: onError, errorCode: RCNetworkConstants.inValidResponse.rawValue, errorDescription: RCNetworkConstants.inValidResponse.rawValue)
            return
        }
        
        do {
            // Validate Output Response Codable Object for mandatory Parameters

            if ResponseType.self == String.self {

                let responseString = String.init(data: responseData, encoding: .utf8) ?? ""

                DispatchQueue.main.async {
                    onSuccessResponse(responseString as! Self.ResponseType)
                }
            } else {

                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                DispatchQueue.main.async {
                    onSuccessResponse(result)
                }

            }

        } catch let DecodingError.typeMismatch(_, context) {
         self.handleErrorResponse(responseData: responseData, onErrorResponse: onErrorResponse, onError: onError, errorDescription: context.debugDescription,errorCode: RCNetworkConstants.inValidResponse.rawValue)
        } catch let DecodingError.keyNotFound(_, context) {
           self.handleErrorResponse(responseData: responseData, onErrorResponse: onErrorResponse, onError: onError, errorDescription: context.debugDescription,errorCode: RCNetworkConstants.inValidResponse.rawValue)
        } catch let DecodingError.valueNotFound(_, context) {
            self.handleErrorResponse(responseData: responseData, onErrorResponse: onErrorResponse, onError: onError, errorDescription: context.debugDescription,errorCode: RCNetworkConstants.inValidResponse.rawValue)
        } catch let error {
         self.handleErrorResponse(responseData: responseData, onErrorResponse: onErrorResponse, onError: onError, errorDescription: error.localizedDescription,errorCode: RCNetworkConstants.inValidResponse.rawValue)
        }
        
        
    }
    
    func handleErrorResponse(responseData: Data,
                             onErrorResponse: @escaping (ErrorResponseType) -> Void,
                             onError: @escaping(APITimeError) -> Void,
                             errorDescription: String,
                             errorCode: String) {

        do {
            let jsonDecoder = JSONDecoder()
            let customError = try jsonDecoder.decode(ErrorResponseType.self, from: responseData)
            DispatchQueue.main.async {
                onErrorResponse(customError)
            }
        } catch let DecodingError.typeMismatch(_, context) {
            self.handleGenericError(onError: onError, errorCode: RCNetworkConstants.inValidResponse.rawValue, errorDescription: context.debugDescription)
        } catch let DecodingError.keyNotFound(_, context) {
            self.handleGenericError(onError: onError, errorCode: RCNetworkConstants.inValidResponse.rawValue, errorDescription: context.debugDescription)
        } catch let DecodingError.valueNotFound(_, context) {
            self.handleGenericError(onError: onError, errorCode: RCNetworkConstants.inValidResponse.rawValue, errorDescription: context.debugDescription)
        } catch let error {
            self.handleGenericError(onError: onError, errorCode: RCNetworkConstants.inValidResponse.rawValue, errorDescription: error.localizedDescription)
        }
    }
    
    func handleGenericError(onError: @escaping (APITimeError) -> Void, errorCode: String, errorDescription: String) {

        let customError = APITimeError.init(errorCode: errorCode,message: errorDescription)
        DispatchQueue.main.async {
            onError(customError)
        }
        
    }
}

extension URLRequest {
    mutating func applyInterceptors(interceptors: [RequestInterceptor]) {
        for interceptor in interceptors {
            interceptor.interceptRequest(request: &self)
        }
    }
}

extension Response {
    mutating func applyInterceptors(interceptors: [ResponseInterceptor]) {
        for interceptor in interceptors {
            interceptor.interceptResponse(response: &self)
        }
    }
}
