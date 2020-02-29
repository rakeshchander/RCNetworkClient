//
//  CoreNetworkClientMock.swift
//  TwitterSampleTests
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import RCNetworkClient
@testable import TwitterSample

class CoreNetworkClientMock : NetworkDispatcher {
    
    private var targetResponse : Data?
    private var errorResponse : APITimeError?
    
    init(success:Data?, error:APITimeError?) {
        targetResponse = success
        errorResponse = error
    }
    
    func consumeRequest(request: URLRequest, onSuccess: @escaping (HTTPURLResponse, Data?) -> Void, onError: @escaping (APITimeError) -> Void) {
        if targetResponse != nil {
            let fakeResponse = HTTPURLResponse.init()
            onSuccess(fakeResponse, targetResponse)
        }else {
            onError(errorResponse!)
        }
    }
    
}

class MockReferences {
    static var networkClient : CoreNetworkClientMock = CoreNetworkClientMock.init(success: nil, error: nil)
}

extension UserFeedAPI {
    var networkClient: NetworkDispatcher{
            MockReferences.networkClient
    }
}

extension HomeFeedAPI {
    var networkClient: NetworkDispatcher{
            MockReferences.networkClient
    }
}
