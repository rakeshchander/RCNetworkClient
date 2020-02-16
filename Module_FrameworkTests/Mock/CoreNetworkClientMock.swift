//
//  APIInterface.swift
//  NBKMerchantApp
//
//  Created by Comviva on 18/03/19.
//  Copyright © 2019 Comviva. All rights reserved.
//

import Foundation
import iOS_Platform_Library
import iOS_Core_Library

public class CoreNetworkClientMock: NSObject, NetworkDispatcher {
    
    private var successResponse : Data?
    private var errorResponse : Decodable?
    
    public init(success:Data?, error:Decodable?) {
        successResponse = success
        errorResponse = error
    }
    
    public static var serverURL = "MOCK_URL"
    
    public func postRequest(target: String, postBody: Data, mimeType: String, requestInterceptors: [RequestWrapper], responseInterceptors: [ResponseParser], onSuccess: @escaping (Data) -> Void, onError: @escaping (Decodable) -> Void) {
        if successResponse != nil {
            onSuccess(successResponse!)
        }else {
            onError(errorResponse!)
        }
    }
    
}

