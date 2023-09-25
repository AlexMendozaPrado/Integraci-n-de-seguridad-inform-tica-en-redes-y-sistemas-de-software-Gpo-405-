//
//  ThreadReplyViewModel.swift
//  Threads
//
//

import Foundation

class ThreadReplyViewModel: ObservableObject {
    
    func uploadThreadReply(toThread thread: Thread, replyText: String) async throws {
        try await ThreadService.replyToThread(thread, replyText: replyText)
    }
}
