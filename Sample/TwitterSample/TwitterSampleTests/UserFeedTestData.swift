//
//  HomeTestData.swift
//  TwitterSampleTests
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
@testable import TwitterSample

class UserFeedTestData {
    static let validTweetsResponse = """
[{
        "created_at": "22-10-2019",
        "id_str": "23521562352323",
        "text": "First Tweet",
        "user": {
            "id_str": "347347564537",
            "name": "Rakesh",
            "screen_name": "@rakesh",
            "profile_image_url_https": "https://google.com"
        }
    },
    {
        "created_at": "22-10-2019",
        "id_str": "36346345745674",
        "text": "Second Tweet",
        "user": {
            "id_str": "4356437456734",
            "name": "Chander",
            "screen_name": "@chander",
            "profile_image_url_https": "https://google.com"
        }
    },
    {
        "created_at": "22-10-2019",
        "id_str": "12351253122135",
        "text": "Third Tweet",
        "user": {
            "id_str": "123541252352",
            "name": "ishu",
            "screen_name": "@ishu",
            "profile_image_url_https": "https://google.com"
        }
    }

]
"""
    
    static let invalidTweetsResponse = """
{
  status:"123"
}
"""
    
}
