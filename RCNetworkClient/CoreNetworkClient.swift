//
//  APIInterface.swift
//  NBKMerchantApp
//
//  Created by Comviva on 15/03/19.
//  Copyright © 2019 Comviva. All rights reserved.
//

import Foundation

public class CoreNetworkClient: NSObject, NetworkDispatcher {
    public func consumeRequest(request: URLRequest, onSuccess: @escaping (HTTPURLResponse, Data?) -> Void, onError: @escaping (APITimeError) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { (data, httpResponse, error) in

            guard let responseError = error else {
                
                onSuccess((httpResponse as? HTTPURLResponse) ?? HTTPURLResponse.init() , data)

                return
            }

            let customError = APITimeError.init(RCNetworkConstants.networkError.rawValue, responseError.localizedDescription)
            
            onError(customError)

        }

        task.resume()

    }
}
