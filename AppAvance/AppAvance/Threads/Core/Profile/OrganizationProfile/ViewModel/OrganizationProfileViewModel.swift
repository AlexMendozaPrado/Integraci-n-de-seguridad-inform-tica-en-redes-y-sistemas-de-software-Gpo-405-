//
//  OrganizationProfileViewModel.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import Foundation

@MainActor
class OrganizationProfileViewModel: ObservableObject {
    @Published var organization: Organization
    
    init(organization: Organization) {
        self.organization = organization
    }
}

// MARK: - Following

extension OrganizationProfileViewModel {
    func follow() async throws {
        
    }
    
    func unfollow() async throws {
        
    }
    
    func checkIfUserIsFollowed() async -> Bool {
        return false
    }
}
