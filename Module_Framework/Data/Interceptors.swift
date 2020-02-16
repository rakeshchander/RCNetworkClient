//
//  Interceptors.swift
//  Module_Framework
//
//  Created by Comviva on 12/02/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation

public struct Response {
    public let httpResponse : HTTPURLResponse
    public let data : Data?
    
    public init(httpResponse : HTTPURLResponse, data : Data?){
        self.httpResponse = httpResponse
        self.data = data
    }
}

public protocol RequestInterceptor {
    func interceptRequest(request : inout URLRequest) -> URLRequest
}

public protocol ResponseInterceptor {
    func interceptResponse(response: inout Response) -> (Response)
}

public protocol RetryInterceptor {
    func retryRequest(onSuccess: @escaping () -> Void,
                            onError: @escaping (APITimeError) -> Void)
}

public struct APITimeError: Decodable {
    private let message: String
    private let errorCode: String
    private let receivedResponse: Data?

    public init(_ message: String, _ error: String, _ receivedResponse: Data? = nil ) {
        self.message = message
        self.errorCode = error
        self.receivedResponse = receivedResponse
    }

    public var localizedDescription: String {
        return message
    }

    public var errorCodeInResponse: String {
        return errorCode
    }

    public var receivedDataInResponse: Data? {
        return receivedResponse
    }
}
