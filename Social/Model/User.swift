//
//  User.swift
//  Social
//
//  Created by rayner on 05/04/21.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
