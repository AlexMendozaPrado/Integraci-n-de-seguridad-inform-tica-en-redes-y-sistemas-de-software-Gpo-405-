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
    @Published var favorites = [Favorite]()
    @Published var isLoading = false

    init() {
        Task { try await fetchFavorites() }
    }

    func fetchFavorites() async throws {
        var newHeaders = mongoHeaders
        newHeaders["Authorization"] = "Bearer \(token)"

        AF.request("\(mongoBaseUrl)/favorites", method: .get, headers: HTTPHeaders(newHeaders)).responseData { data in
            let json = try! JSON(data: data.data!)
            self.favorites.removeAll()
            for favorite in json {
                let socialNetworksArray: [Favorite.SocialNetwork] = favorite.1["socialNetworks"].arrayValue.map { socialNetworkObject in
                    let name = socialNetworkObject["name"].stringValue
                    let url = socialNetworkObject["url"].stringValue
                    return Favorite.SocialNetwork(name: name, url: url)
                }

                let tagsArray: [String] = favorite.1["tags"].arrayValue.map { value in
                    return value.stringValue
                }

                let org = Favorite(
                    favoriteId: favorite.1["favoriteId"].stringValue,
                    id: favorite.1["_id"].stringValue,
                    userId: favorite.1["userId"].stringValue,
                    name: favorite.1["name"].stringValue,
                    address: Favorite.Address(
                        street1: favorite.1["address"]["street1"].stringValue,
                        street2: favorite.1["address"]["street2"].stringValue,
                        city: favorite.1["address"]["city"].stringValue,
                        state: favorite.1["address"]["state"].stringValue,
                        zipCode: favorite.1["address"]["zipCode"].stringValue,
                        country: favorite.1["address"]["country"].stringValue
                    ),
                    contact: Favorite.Contact(
                        phoneNumber: favorite.1["contact"]["phoneNumber"].stringValue,
                        email: favorite.1["contact"]["email"].stringValue
                    ),
                    description: favorite.1["description"].stringValue,
                    socialNetworks: socialNetworksArray,
                    logoUrl: favorite.1["logoUrl"].stringValue,
                    tags: tagsArray,
                    createdAt: Date(),
                    updatedAt: Date()
                )

                self.favorites.append(org)
            }
        }
    }

    func removeFavorite(favoriteId: String) async throws {
        var newHeaders = mongoHeaders
        newHeaders["Authorization"] = "Bearer \(token)"

        _ = AF.request("\(mongoBaseUrl)/favorites/\(favoriteId)", method: .delete, headers: HTTPHeaders(newHeaders)).responseData { data in
            /* let json = try! JSON(data: data.data!) */
            Task { try await self.fetchFavorites() }
        }
    }


}
