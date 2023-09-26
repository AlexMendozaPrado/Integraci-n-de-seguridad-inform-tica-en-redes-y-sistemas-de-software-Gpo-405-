//
//  Post.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 25/09/23.
//

import Foundation

struct Post: Identifiable, Codable, Hashable {
    var id: String
    let organizationId: String
    let title: String
    let postType: String
    let content: String
    let fileResults: [String]
    let createdAt: Date
}
