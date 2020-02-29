//
//  HomeViewModel.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel : TweetViewModel {
    
    let dataSource: HomeDataSource
    var delegate: HomeFlowDelegate?
    
    var searchText : String = "" {
        didSet (newValue) {
            self.performFeedRefresh()
        }
    }
    
    private var tweetsData : [TweetDAO] = []
    
    init(delegate: HomeFlowDelegate?, dataSource: HomeDataSource) {
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    func performFeedAutoRefresh(){
        let latestID = self.tweetsData.first?.id_str ?? ""
        
        let queryParams = ["q": (searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""), "since_id" : latestID]
        
        HomeFeedAPI().execute(requestParams: queryParams, onSuccessResponse: { [weak self] (response) in
            self?.handleLatestResponse(response: response)
        }, onErrorResponse: { [weak self] (error) in
            self?.tweetsUpdatedErrorHandler?()
        }) { [weak self] (error) in
            self?.tweetsUpdatedErrorHandler?()
        }

        
    }
    
    func performFeedRefresh(latestId: String? = nil, paginatedId : String? = nil) {
        
        let queryParams = ["q": (searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")]
        
        HomeFeedAPI().execute(requestParams: queryParams, onSuccessResponse: { [weak self] (response) in
            self?.handleSearchResponse(response: response)
        }, onErrorResponse: { [weak self] (error) in
            self?.tweetsUpdatedErrorHandler?()
        }) { [weak self] (error) in
            self?.tweetsUpdatedErrorHandler?()
        }
        
    }
    
    func performFeedPagination(latestId: String? = nil, paginatedId : String? = nil) {
        
        let lastId = self.tweetsData.last?.id_str ?? ""
        
        let queryParams = ["q": (searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""), "max_id" : lastId]
        
        HomeFeedAPI().execute(requestParams: queryParams, onSuccessResponse: { [weak self] (response) in
            self?.handlePaginatedResponse(response: response)
        }, onErrorResponse: { [weak self] (error) in
            self?.tweetsUpdatedErrorHandler?()
        }) { [weak self] (error) in
            self?.tweetsUpdatedErrorHandler?()
        }
        
    }
    
    func handleUserSelection(index : Int){
        let user = self.tweetsData[index].user
        self.delegate?.startUserTweetsFlow(user: user)
    }
    
    func handlePaginatedResponse(response : HomeResponseDAO) {
        _ = response.statuses.map { (tweet) -> TweetItem in
            
            let item = TweetItem.init(tweet: tweet.text, userName: tweet.user.name, userId: tweet.user.screen_name, iconUrl: tweet.user.profile_image_url_https)
            
            self.tweetItems.append(item)
            self.tweetsData.append(tweet)
            
            return item
            
        }
        
        self.tweetsUpdatedSuccessHandler?()
    }
    
    func handleLatestResponse(response : HomeResponseDAO) {
        _ = response.statuses.map { (tweet) -> TweetItem in
            
            let item = TweetItem.init(tweet: tweet.text, userName: tweet.user.name, userId: tweet.user.screen_name, iconUrl: tweet.user.profile_image_url_https)
            
            self.tweetItems.insert(item, at: 0)
            self.tweetsData.insert(tweet, at: 0)
            
            return item
            
        }
        
        self.tweetsUpdatedSuccessHandler?()
    }
    
    func handleSearchResponse(response: HomeResponseDAO) {
        self.tweetItems = response.statuses.map { (tweet) -> TweetItem in
            
            let item = TweetItem.init(tweet: tweet.text, userName: tweet.user.name, userId: tweet.user.screen_name, iconUrl: tweet.user.profile_image_url_https)
            
            return item
            
        }
        
        self.tweetsData = response.statuses
        
        self.tweetsUpdatedSuccessHandler?()
    }
    
}
