//
//  UserFeedViewController.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//Copyright © 2020 Comviva. All rights reserved.
//

import UIKit

class UserFeedViewController: UIViewController {
    
    var viewModel : UserFeedViewModel?
    
    @IBOutlet weak var itemsListView : UITableView!
    
    let listDataSource : TweetListDataSource = TweetListDataSource.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemsListView.register(UINib.init(nibName: "TweetTableViewCell", bundle: .main), forCellReuseIdentifier: "TweetTableViewCell")
        self.itemsListView.register(UINib.init(nibName: "LoadMoreTableViewCell", bundle: .main), forCellReuseIdentifier: "LoadMoreTableViewCell")
        
        self.viewModel?.tweetsUpdatedSuccessHandler = {
            self.itemsListView.reloadData()
        }
        
        self.viewModel?.tweetsUpdatedErrorHandler = {
            self.viewModel?.tweetItems.removeAll()
            self.itemsListView.reloadData()
        }
        
        listDataSource.viewModel = self.viewModel
        
        self.itemsListView.dataSource = listDataSource
        
        self.viewModel?.performUserFeedAction(callback: { (status, message) in
            
        })
        
        self.title = self.viewModel?.twitterUser.name
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension UserFeedViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < self.viewModel?.tweetItems.count ?? 0 {
            //Do Nothing
        } else {
            //Do Pagination
        }
    }
    
    
}
