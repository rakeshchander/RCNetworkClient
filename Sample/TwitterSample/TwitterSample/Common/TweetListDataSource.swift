//
//  TweetListDataSource.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class TweetListDataSource : NSObject, UITableViewDataSource{
    var viewModel : TweetViewModel?
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.viewModel?.tweetItems.count, count > 0 {
            return count + 1
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < self.viewModel?.tweetItems.count ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell") as! TweetTableViewCell
            
            cell.iconView.image = nil
            
            let item = self.viewModel?.tweetItems[indexPath.row]
            
            cell.idLabel.text = item?.userId
            cell.nameLabel.text = item?.userName
            cell.msgLabel.text = item?.tweet
            
            if let imgUrl = URL.init(string: item?.iconUrl ?? "") {
                   Nuke.loadImage(with: imgUrl, into: cell.iconView)
            }
            
            cell.accessibilityIdentifier = "TweetCell\(indexPath.row)"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreTableViewCell") as! LoadMoreTableViewCell
            
            cell.accessibilityIdentifier = "LoadMoreTableViewCell"
            
            return cell
        }
        
    }
    
}
