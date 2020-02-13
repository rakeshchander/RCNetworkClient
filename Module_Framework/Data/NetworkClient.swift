//
//  NetworkClient.swift
//  Module_Framework
//
//  Created by Comviva on 12/02/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation

public protocol NetworkDispatcher {
    func consumeRequest(request: URLRequest,
                                          onSuccess: @escaping (HTTPURLResponse, Data?) -> Void,
                                          onError: @escaping (APITimeError) -> Void)
}
