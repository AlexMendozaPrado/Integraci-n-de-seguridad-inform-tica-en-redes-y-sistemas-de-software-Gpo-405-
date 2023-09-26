//
//  Organization.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import Foundation

struct Organization: Identifiable, Hashable {
    struct Address: Hashable {
        let street1: String
        let street2: String
        let city: String
        let state: String
        let zipCode: String
        let country: String
    }
    
    struct Contact: Hashable {
        let phoneNumber: String
        let email: String
    }
    
    struct SocialNetwork: Hashable {
        let name: String
        let url: String
    }
    
    let id: String
    let userId: String
    let name: String
    let address: Address
    let contact: Contact
    let description: String?
    let socialNetworks: [SocialNetwork]
    let logoUrl: String?
    let tags: [String]
    let createdAt: Date
    let updatedAt: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

