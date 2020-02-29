//
//  UserFeedViewModel.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import UIKit

class UserFeedViewModel : TweetViewModel {
    
    let twitterUser : UserDAO
    
    let dataSource: UserFeedDataSource
    
    private var tweetsData : [TweetDAO] = []
    
    init(dataSource: UserFeedDataSource, twitterUser : UserDAO) {
        self.dataSource = dataSource
        self.twitterUser = twitterUser
    }
    
    func performUserFeedAction(callback:@escaping (_ statusCode: String, _ message: String?) -> Void) {
        
        let queryParams = ["user_id": self.twitterUser.id_str]
        
        UserFeedAPI().execute(requestParams: queryParams, onSuccessResponse: { [weak self] (response) in
            self?.tweetItems = response.map { (tweet) -> TweetItem in
                
                let item = TweetItem.init(tweet: tweet.text, userName: tweet.user.name, userId: tweet.user.screen_name, iconUrl: tweet.user.profile_image_url_https)
                
                return item
                
            }
            self?.tweetsData = response
            self?.tweetsUpdatedSuccessHandler?()
        }, onErrorResponse: { [weak self] (errorResponse) in
            self?.tweetsUpdatedErrorHandler?()
        }) { [weak self] (error) in
            self?.tweetsUpdatedErrorHandler?()
        }
        
    }
    
}
