//
//  FeedViewModel.swift
//  Threads
//
//

import SwiftUI
import Alamofire
import SwiftyJSON

@MainActor
class FeedViewModel: ObservableObject {
    @AppStorage("token") var token: String = ""
    @Published var posts = [Post]()
    @Published var isLoading = false

    init() {
        Task { await fetchPosts() }
    }

    func fetchPosts() async {
        isLoading = true
        var newHeaders = mongoHeaders
        newHeaders["Authorization"] = "Bearer \(token)"
        var organization: Organization? = nil

        AF.request("\(mongoBaseUrl)/posts", method: .get, headers: HTTPHeaders(newHeaders)).responseData { response in
            switch response.result {
            case .success(let data):
                let json = try? JSON(data: data)
                let fetchedPosts = json?.arrayValue.map { data in
                    AF.request("\(mongoBaseUrl)/organizations/\(data["organizationId"].stringValue)", method: .get, headers: HTTPHeaders(newHeaders)).responseData { organizationResponse in
                        switch organizationResponse.result {
                        case .success(let orgData):
                            let organizationJson = try? JSON(data: orgData)
                            let socialNetworksArray: [Organization.SocialNetwork] = organizationJson?["socialNetworks"].arrayValue.map { socialNetworkObject in
                                let name = socialNetworkObject["name"].stringValue
                                let url = socialNetworkObject["url"].stringValue
                                return Organization.SocialNetwork(name: name, url: url)
                            } ?? []
                            
                            let tagsArray: [String] = organizationJson?["tags"].arrayValue.map { value in
                                return value.stringValue
                            } ?? []
                            
                            organization = Organization(
                                id: organizationJson?["_id"].stringValue ?? "",
                                userId: organizationJson?["userId"].stringValue ?? "",
                                name: organizationJson?["name"].stringValue ?? "",
                                userName: organizationJson?["userName"].stringValue ?? "",
                                rfc: organizationJson?["rfc"].stringValue ?? "",
                                schedule: organizationJson?["schedule"].stringValue ?? "",
                                address: Organization.Address(
                                    street1: organizationJson?["address"]["street1"].stringValue ?? "",
                                    street2: organizationJson?["address"]["street2"].stringValue ?? "",
                                    city: organizationJson?["address"]["city"].stringValue ?? "",
                                    state: organizationJson?["address"]["state"].stringValue ?? "",
                                    zipCode: organizationJson?["address"]["zipCode"].stringValue ?? "",
                                    country: organizationJson?["address"]["country"].stringValue ?? ""
                                ),
                                contact: Organization.Contact(
                                    phoneNumber: organizationJson?["contact"]["phoneNumber"].stringValue ?? "",
                                    email: organizationJson?["contact"]["email"].stringValue ?? ""
                                ),
                                description: organizationJson?["description"].stringValue ?? "",
                                socialNetworks: socialNetworksArray,
                                logoUrl: organizationJson?["logoUrl"].stringValue ?? "",
                                videoUrl: organizationJson?["videoUrl"].stringValue ?? "",
                                bannerUrl: organizationJson?["bannerUrl"].stringValue ?? "",
                                tags: tagsArray,
                                createdAt: Date(),
                                updatedAt: Date()
                            )
                        case .failure(let error):
                            print("Request Error Organization: \(error)")
                        }
                    }
                    
                    return Post(
                        id: data["_id"].stringValue,
                        organization: organization!,
                        title: data["title"].stringValue,
                        postType: data["postType"].stringValue,
                        content: data["content"].stringValue,
                        filesUrls: data["filesIds"].arrayValue.map { dataId in
                            dataId.stringValue
                        },
                        createdAt: Date.now
                    )
                }
                self.posts = fetchedPosts ?? []
                self.isLoading = false
            case .failure(let error):
                print("Request Error: \(error)")
            }
        }
    }
}
