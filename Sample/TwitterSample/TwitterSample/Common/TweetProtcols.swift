//
//  TweetProtcols.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation

protocol TweetFlowDelegate : AnyObject{
    func startUserTweetsFlow(user : UserDAO)
}
