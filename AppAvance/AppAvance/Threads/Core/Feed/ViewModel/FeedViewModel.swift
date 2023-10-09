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

        AF.request("\(mongoBaseUrl)/posts", method: .get, headers: HTTPHeaders(newHeaders)).responseData { response in
            switch response.result {
            case .success(let data):
                let json = try? JSON(data: data)
                let posts = json?["data"].arrayValue.map { data in
                    Post(
                        id: data["_id"].stringValue,
                        organizationId: data["organizationId"].stringValue,
                        title: data["title"].stringValue,
                        postType: data["postType"].stringValue,
                        content: data["content"].stringValue,
                        fileResults: data["fileResults"].arrayValue.map { data in
                            data.stringValue
                        },
                        createdAt: Date.now
                    )
                }
                self.posts = posts ?? []
                self.isLoading = false
                print(self.posts)
            case .failure(let error):
                print("Request Error: \(error)")
            }
        }
    }
}
