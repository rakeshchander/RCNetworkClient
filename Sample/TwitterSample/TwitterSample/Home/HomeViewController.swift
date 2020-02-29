//
//  HomeViewController.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//Copyright © 2020 Comviva. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel : HomeViewModel?
    
    @IBOutlet weak var itemsListView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    var refreshTimer : Timer?
    
    let listDataSource : TweetListDataSource = TweetListDataSource.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.accessibilityIdentifier = "SearchBarID"
        
        self.itemsListView.register(UINib.init(nibName: "TweetTableViewCell", bundle: .main), forCellReuseIdentifier: "TweetTableViewCell")
        self.itemsListView.register(UINib.init(nibName: "LoadMoreTableViewCell", bundle: .main), forCellReuseIdentifier: "LoadMoreTableViewCell")
        
        self.viewModel?.tweetsUpdatedSuccessHandler = {
            self.itemsListView.reloadData()
        }
        
        self.viewModel?.tweetsUpdatedErrorHandler = {
            self.startHomeFeed(searchText: "")
        }
        
        listDataSource.viewModel = self.viewModel
        
        self.itemsListView.dataSource = listDataSource
        
        self.title = "Tweets"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func startHomeFeed(searchText : String) {
        self.viewModel?.searchText = searchText
        
        if searchText.isEmpty {
            self.viewModel?.tweetItems.removeAll()
            self.itemsListView.reloadData()
            self.refreshTimer?.invalidate()
        } else {
            
            self.viewModel?.performFeedRefresh()
            self.refreshTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { (timer) in
                self.viewModel?.performFeedAutoRefresh()
            }
        }
    }

}

extension HomeViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.startHomeFeed(searchText: searchBar.text ?? "")
        searchBar.resignFirstResponder()
        
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < self.viewModel?.tweetItems.count ?? 0 {
            self.viewModel?.handleUserSelection(index: indexPath.row)
        } else {
            self.viewModel?.performFeedPagination()
        }
    }
    
    
}
