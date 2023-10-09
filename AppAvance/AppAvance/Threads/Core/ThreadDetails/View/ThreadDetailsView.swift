//
//  ThreadDetailsView.swift
//  Threads
//
//

import SwiftUI
import WebKit

struct ThreadDetailsView: View {
    @State private var showReplySheet = false
    @StateObject var viewModel: ThreadDetailsViewModel
    
    private var thread: Thread {
        return viewModel.thread
    }
    
    init(thread: Thread) {
        self._viewModel = StateObject(wrappedValue: ThreadDetailsViewModel(thread: thread))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CircularProfileImageView(user: thread.user, size: .small)
                    
                    Text(thread.user?.username ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text("12m")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray3))
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color(.darkGray))
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(thread.caption)
                        .font(.subheadline)
                    
                    // Desplegar el video de Youtube
                    if let videoURL = thread.videoURL, !videoURL.isEmpty {
                        WebView(urlString: videoURL)
                            .frame(height: 200)
                    }
                    
                    // Desplegar la descripción
                    if let videoDescription = thread.videoDescription, !videoDescription.isEmpty {
                        Text(videoDescription)
                            .font(.footnote)
                    }
                    
                    ContentActionButtonView(viewModel: ContentActionButtonViewModel(contentType: .thread(thread)))
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
                .padding(.vertical)
            
            LazyVStack(spacing: 16) {
                ForEach(viewModel.replies) { reply in
                    ThreadCell(config: .reply(reply))
                }
            }
        }
        .sheet(isPresented: $showReplySheet, content: {
            ThreadReplyView(thread: thread)
        })
        .padding()
        .navigationTitle("Thread")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ThreadDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ThreadDetailsView(thread: dev.thread)
    }
}
