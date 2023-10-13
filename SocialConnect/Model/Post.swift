//
//  Post.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 25/09/23.
//

import Foundation

struct Post: Identifiable, Codable, Hashable {
    var id: String
    let organization: Organization
    let title: String
    let postType: String
    let content: String
    let filesUrls: [String]
    let createdAt: Date
}
