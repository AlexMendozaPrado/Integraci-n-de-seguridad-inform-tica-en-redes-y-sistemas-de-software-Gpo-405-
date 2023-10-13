//
//  ThreadDetailsViewModel.swift
//  Threads
//
//

import Foundation

@MainActor
class PostDetailsViewModel: ObservableObject {
    @Published var post: Post
    @Published var replies = [PostReply]()
    
    init(post: Post, replies: [PostReply] = [PostReply]()) {
        self.post = post
        self.replies = replies
    }
}
