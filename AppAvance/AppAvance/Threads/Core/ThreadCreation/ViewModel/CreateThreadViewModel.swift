//
//  CreateThreadViewModel.swift
//  Threads
//
//

import Foundation
import Firebase

class CreateThreadViewModel: ObservableObject {
    
    @Published var caption = ""
    @Published var videoDescription = ""
    @Published var videoURL = ""
    
    func uploadThread() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let thread = Thread(
            ownerUid: uid,
            caption: caption,
            videoDescription: videoDescription,
            videoURL: videoURL,
            timestamp: Timestamp(),
            likes: 0,
            replyCount: 0
        )
        try await ThreadService.uploadThread(thread)
    }
}
