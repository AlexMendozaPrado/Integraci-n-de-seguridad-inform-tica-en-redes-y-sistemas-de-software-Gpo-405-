import Foundation

class CreatePostViewModel: ObservableObject {
    @Published var caption = ""
    @Published var videoDescription = ""
    @Published var videoURL = ""
    
    func createPost() async throws {
        
    }
}
