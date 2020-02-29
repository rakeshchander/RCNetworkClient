//
//  TwitterSampleTests.swift
//  TwitterSampleTests
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import XCTest


class TwitterSampleUserFeedTests: XCTestCase {
    
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

    func testUserFeedFlow() {

        let data = UserFeedTestData.validTweetsResponse.data(using: .utf8)
        MockReferences.networkClient = CoreNetworkClientMock.init(success: data, error: nil)
        
        let user = UserDAO.init(id_str: "123412451", name: "Rakesh", screen_name: "@Rakesh", profile_image_url_https: "google.com")
        
        
        let dataSource = UserFeedDataSource.init()
        let viewModel = UserFeedViewModel.init(dataSource: dataSource, twitterUser: user)
        
        viewModel.performUserFeedAction { (status, message) in
            
        }
        
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
}
