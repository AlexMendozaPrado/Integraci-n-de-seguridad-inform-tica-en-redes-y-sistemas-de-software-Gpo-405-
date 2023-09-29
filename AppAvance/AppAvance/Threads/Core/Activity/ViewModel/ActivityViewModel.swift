// ActivityViewModel.swift
// Threads
//
//

import SwiftUI
import Alamofire
import SwiftyJSON

@MainActor
class ActivityViewModel: ObservableObject {
    @AppStorage("token") var token: String = ""
    @Published var organizations = [Organization]()
    @Published var isLoading = false

    init() {
        Task { try await fetchOrganizations() }
    }

    private func fetchOrganizations() async throws {
        var newHeaders = mongoHeaders
        newHeaders["Authorization"] = "Bearer \(token)"
        
        AF.request("\(mongoBaseUrl)/favorites", method: .get, headers: HTTPHeaders(newHeaders)).responseData { data in
            let json = try! JSON(data: data.data!)
            self.organizations.removeAll()
            for organization in json {
                let socialNetworksArray: [Organization.SocialNetwork] = organization.1["socialNetworks"].arrayValue.map { socialNetworkObject in
                    let name = socialNetworkObject["name"].stringValue
                    let url = socialNetworkObject["url"].stringValue
                    return Organization.SocialNetwork(name: name, url: url)
                }
                
                let tagsArray: [String] = organization.1["tags"].arrayValue.map { value in
                    return value.stringValue
                }
                
                let org = Organization(
                    id: organization.1["_id"].stringValue,
                    userId: organization.1["userId"].stringValue,
                    name: organization.1["name"].stringValue,
                    address: Organization.Address(
                        street1: organization.1["address"]["street1"].stringValue,
                        street2: organization.1["address"]["street2"].stringValue,
                        city: organization.1["address"]["city"].stringValue,
                        state: organization.1["address"]["state"].stringValue,
                        zipCode: organization.1["address"]["zipCode"].stringValue,
                        country: organization.1["address"]["country"].stringValue
                    ),
                    contact: Organization.Contact(
                        phoneNumber: organization.1["contact"]["phoneNumber"].stringValue,
                        email: organization.1["contact"]["email"].stringValue
                    ),
                    description: organization.1["description"].stringValue,
                    socialNetworks: socialNetworksArray,
                    logoUrl: organization.1["logoUrl"].stringValue,
                    tags: tagsArray,
                    createdAt: Date(),
                    updatedAt: Date()
                )
                
                self.organizations.append(org)
            }
            
            print(self.organizations.count)
        }
    }
    
    
}
