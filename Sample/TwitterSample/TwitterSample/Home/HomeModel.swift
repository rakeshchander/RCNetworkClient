//
//  HomeModel.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//Copyright © 2020 Comviva. All rights reserved.
//

import Foundation
import RCNetworkClient

struct HomeResponseDAO: Decodable {
    let statuses : [TweetDAO]
}

struct TweetDAO: Decodable {
    let created_at : String
    let id_str : String
    let text : String
    let user : UserDAO
}

struct UserDAO: Decodable {
    let id_str : String
    let name : String
    let screen_name : String
    let profile_image_url_https : String
}
