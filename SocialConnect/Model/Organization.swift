//
//  Organization.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import Foundation

struct Organization: Identifiable, Codable, Hashable {
    struct Address: Hashable, Codable {
        let street1: String
        let street2: String
        let city: String
        let state: String
        let zipCode: String
        let country: String
    }
    
    struct Contact: Hashable, Codable {
        let phoneNumber: String
        let email: String
    }
    
    struct SocialNetwork: Hashable, Codable {
        let name: String
        let url: String
    }
    
    let id: String
    let userId: String
    let name: String
    let userName: String?
    let rfc: String?
    let schedule: String?
    let address: Address
    let contact: Contact
    let description: String?
    let socialNetworks: [SocialNetwork]
    let logoUrl: String?
    let videoUrl: String?
    let bannerUrl: String
    let tags: [String]
    let createdAt: Date
    let updatedAt: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

