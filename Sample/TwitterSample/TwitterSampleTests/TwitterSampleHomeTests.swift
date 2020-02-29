//
//  TwitterSampleTests.swift
//  TwitterSampleTests
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import XCTest
@testable import TwitterSample

class TwitterSampleHomeTests: XCTestCase {
    
    func wait(interval: TimeInterval = 2, completion: @escaping (() -> Void)) {
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
            exp.fulfill()
        }
        waitForExpectations(timeout: interval + 1)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = true
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFreshSearchFlow() {

        let data = HomeTestData.validTweetsResponse.data(using: .utf8)
        MockReferences.networkClient = CoreNetworkClientMock.init(success: data, error: nil)
        
        
        let dataSource = HomeDataSource.init()
        let viewModel = HomeViewModel.init(delegate: nil, dataSource: dataSource)
        
        viewModel.searchText = "test"
        
        viewModel.performFeedRefresh()
        
        viewModel.tweetsUpdatedSuccessHandler = {
            XCTAssertTrue(viewModel.tweetItems.count == 3)
        }
        
        viewModel.tweetsUpdatedErrorHandler = {
            XCTAssertTrue(false)
        }

        self.wait {
            print("Wait completed")
        }
    }
    
    func testAutoFreshFlow() {
        
        let data = HomeTestData.validTweetsResponse.data(using: .utf8)
        MockReferences.networkClient = CoreNetworkClientMock.init(success: data, error: nil)
        
        let dataSource = HomeDataSource.init()
        let viewModel = HomeViewModel.init(delegate: nil, dataSource: dataSource)
        
        viewModel.performFeedAutoRefresh()
        
        
        viewModel.tweetsUpdatedSuccessHandler = {
            XCTAssertTrue(viewModel.tweetItems.count == 3)
        }
        
        viewModel.tweetsUpdatedErrorHandler = {
            XCTAssertTrue(false)
        }

        self.wait {
            print("Wait completed")
        }
    }
    
    func testPaginatedFlow() {
        
        let data = HomeTestData.validTweetsResponse.data(using: .utf8)
        MockReferences.networkClient = CoreNetworkClientMock.init(success: data, error: nil)
        
        let dataSource = HomeDataSource.init()
        let viewModel = HomeViewModel.init(delegate: nil, dataSource: dataSource)
        
        viewModel.performFeedPagination()
        
        
        viewModel.tweetsUpdatedSuccessHandler = {
            XCTAssertTrue(viewModel.tweetItems.count == 3)
        }
        
        viewModel.tweetsUpdatedErrorHandler = {
            XCTAssertTrue(false)
        }

        self.wait {
            print("Wait completed")
        }
    }
    
    func testNavigationFlow() {
        
        let data = HomeTestData.validTweetsResponse.data(using: .utf8)
        MockReferences.networkClient = CoreNetworkClientMock.init(success: data, error: nil)
        
        let dataSource = HomeDataSource.init()
        let mockNavigator = HomeNavigatorMock()
        let viewModel = HomeViewModel.init(delegate: mockNavigator, dataSource: dataSource)
        
        
        viewModel.performFeedRefresh()
        
        viewModel.tweetsUpdatedSuccessHandler = {
            
            viewModel.handleUserSelection(index: 0)
            
            XCTAssertTrue(mockNavigator.navigationStatus)
        }
        
        viewModel.tweetsUpdatedErrorHandler = {
            XCTAssertTrue(false)
        }

        self.wait {
            print("Wait completed")
        }
    }

}
