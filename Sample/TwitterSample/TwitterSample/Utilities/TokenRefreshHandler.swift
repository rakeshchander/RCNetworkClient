//
//  TokenRefreshWrapper.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import RCNetworkClient

struct AppTokenDAO : Decodable {
    let token_type : String
    let access_token : String
}

struct AppTokenErrorDAO : Decodable {
    
}

class TokenRequestHeaderInterceptor : RequestInterceptor{
    
    func interceptRequest(request: inout URLRequest) {
        
        let encodedConsumerKeyString:String = Constants.twitterConsumerKey.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
        let encodedConsumerSecretKeyString:String = Constants.twitterSecretKey.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
        
        let combinedString = encodedConsumerKeyString+":"+encodedConsumerSecretKeyString
        print(combinedString)
        //Base64 encoding
        let data = combinedString.data(using: .utf8)
        let encodingString = "Basic "+(data?.base64EncodedString())!
        
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        request.addValue(encodingString, forHTTPHeaderField: "Authorization")
    
    }
    
}

struct RefreshAppTokenAPI: POSTAPIRequest {
    
    
    typealias RequestBodyType = String
    
    typealias ResponseType = AppTokenDAO
    
    typealias ErrorResponseType = AppTokenErrorDAO
    
    var endPoint: String {
        return PlatformConstants.serverURL + PlatformConstants.refreshAppToken
    }
    
    var interceptors: (requestInterceptors: [RequestInterceptor], responseInterceptors: [ResponseInterceptor])? {
        return ([TokenRequestHeaderInterceptor()],[])
    }
    
}

class AppTokenRefreshWrapper : RetryInterceptor{
    
    func retryRequest(onSuccess: @escaping () -> Void, onError: @escaping (APITimeError) -> Void) {
        let params : String = "grant_type=client_credentials"
        
        RefreshAppTokenAPI().execute(requestBody: params, onSuccessResponse: { (appToken) in
            APIDataManager.appToken = appToken.access_token
            onSuccess()
        }, onErrorResponse: { (error) in
            onError(APITimeError.init(errorCode: RCNetworkConstants.inValidResponse.rawValue, message: RCNetworkConstants.inValidResponse.rawValue))
        }) { (error) in
            onError(error)
        }
        
    }
    
}
