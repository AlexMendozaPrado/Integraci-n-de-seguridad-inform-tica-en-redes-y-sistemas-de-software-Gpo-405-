import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

@MainActor
class ExploreViewModel: ObservableObject {
    @AppStorage("token") var token: String = ""
    @Published var organizations = [Organization]()
    @Published var organizationFiles: [OrganizationFiles] = []
    @Published var tags = [Tag]()
    @Published var isLoading = false
    
    init() {
        Task { try fetchOrganizations(tags: nil) }
        Task { try fetchTags() }
    }
    
    func fetchOrganizations(tags: [String]?) throws {
        var newHeaders = mongoHeaders
        newHeaders["Authorization"] = "Bearer \(token)"
        
        var parameters: [String: Any] = [
            "useUserTags": false
        ]
        
        if tags != nil {
            parameters = [
                "userUserTags": false,
                "tags": tags ?? [""]
            ]
        }
        
        AF.request("\(mongoBaseUrl)/organizations", method: .get, parameters: parameters, headers: HTTPHeaders(newHeaders)).responseData { data in
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
                    userName: organization.1["userName"].stringValue,
                    rfc: organization.1["rfc"].stringValue,
                    schedule: organization.1["schedule"].stringValue,
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
                    videoUrl: organization.1["videoUrl"].stringValue,
                    bannerUrl: organization.1["bannerUrl"].stringValue,
                    tags: tagsArray,
                    createdAt: Date(),
                    updatedAt: Date()
                )
                
                self.organizations.append(org)
            }
        }
    }
    
    func fetchTags() throws {
        var newHeaders = mongoHeaders
        newHeaders["Authorization"] = "Bearer \(token)"
        
        AF.request("\(mongoBaseUrl)/tags", method: .get, headers: HTTPHeaders(newHeaders)).responseData { data in
            let json = try! JSON(data: data.data!)
            for tag in json {
                let newTag = Tag(
                    id: tag.1["_id"].stringValue,
                    name: tag.1["name"].stringValue,
                    description: tag.1["description"].stringValue,
                    createdAt: Date(),
                    updatedAt: Date(),
                    updatedBy: tag.1["updatedBy"].stringValue
                )

                self.tags.append(newTag)
            }
        }
    }
    
    func fetchFiles(for organizationId: String) {
        let urlString = "\(mongoBaseUrl)/files?organizationId=\(organizationId)"

        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: [OrganizationFiles].self) { [weak self] response in
                switch response.result {
                case .success(let files):
                    self?.organizationFiles = files
                case .failure(let error):
                    print("Error fetching files: \(error)")
                }
            }
    }
    
    func filteredOrganizations(_ query: String) -> [Organization] {
        let lowercasedQuery = query.lowercased()
        
        return organizations.filter({
            $0.name.lowercased().contains(lowercasedQuery)
        })
    }
}