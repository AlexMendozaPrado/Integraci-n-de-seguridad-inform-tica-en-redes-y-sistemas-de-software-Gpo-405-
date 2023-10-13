//
//  User.swift
//  Threads
//
//

import Foundation

struct User: Identifiable, Codable {
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
    var link: String?
    var stats: UserStats?
    var isFollowed: Bool?
    let id: String
}

struct UserStats: Codable {
    var followersCount: Int
    var followingCount: Int
    var threadsCount: Int
}

extension User: Hashable {
    var identifier: String { return id }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
