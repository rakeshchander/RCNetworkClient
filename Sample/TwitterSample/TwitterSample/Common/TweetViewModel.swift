//
//  TweetViewModel.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation

struct TweetItem {
    let tweet : String
    let userName : String
    let userId : String
    let iconUrl: String
}

class TweetViewModel {
    
    var tweetItems: [TweetItem] = []
    
    var tweetsUpdatedSuccessHandler : (() -> Void)?
    var tweetsUpdatedErrorHandler : (() -> Void)?
    
}
