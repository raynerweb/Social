//
//  UserPost.swift
//  Social
//
//  Created by rayner on 11/04/21.
//

import Foundation

struct PostUser: Codable, Identifiable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
