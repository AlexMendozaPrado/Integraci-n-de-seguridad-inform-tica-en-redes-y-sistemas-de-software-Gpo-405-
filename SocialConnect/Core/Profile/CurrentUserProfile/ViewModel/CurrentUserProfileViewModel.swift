import Foundation
import Combine
import SwiftUI
import PhotosUI

@MainActor
class CurrentUserProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var posts = [Post]()
    @Published var replies = [PostReply]()
    @Published var profileImage: Image?
    @Published var tags = ""
    @Published var link = ""
    
    private var uiImage: UIImage?
    private var cancellables = Set<AnyCancellable>()
}
