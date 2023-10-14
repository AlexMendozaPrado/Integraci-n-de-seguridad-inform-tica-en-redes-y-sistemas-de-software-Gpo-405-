//
//  OrganizationProfileViewModel.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

@MainActor
class OrganizationProfileViewModel: ObservableObject {
    @AppStorage("token") var token: String = ""
    @Published var organization: Organization
    
    init(organization: Organization) {
        self.organization = organization
    }
    
    func markAsFavorite(organizationId: String) {
        var newHeaders = mongoHeaders
        newHeaders["Authorization"] = "Bearer \(token)"
        
        let parameters: [String: String] = [
            "organizationId": organizationId
        ]
        
        AF.request("\(mongoBaseUrl)/favorites", method: .post, parameters: JSON(parameters), headers: HTTPHeaders(mongoHeaders)).responseData { response in
            switch response.result {
                case .success(let data):
                    let json = try? JSON(data: data)
                    print(json as Any)
                case .failure(let error):
                    print("Request Error: \(error)")
            }
        }
    }
    
    func unmarkAsFavorite(organizationId: String) {
        var newHeaders = mongoHeaders
        newHeaders["Authorization"] = "Bearer \(token)"
        let url = "\(mongoBaseUrl)/favorites/\(organizationId)"
        
        AF.request(url, method: .delete, encoding: URLEncoding.default, headers: HTTPHeaders(mongoHeaders)).responseData { response in
            switch response.result {
            case .success(let data):
                let json = try? JSON(data: data)
                print(json as Any)
            case .failure(let error):
                print("Request Error: \(error)")
            }
        }
    }
}
