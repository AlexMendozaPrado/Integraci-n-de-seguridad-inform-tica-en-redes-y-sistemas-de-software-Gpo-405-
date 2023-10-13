//
//  FeedView.swift
//  Threads
//
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                
                if !viewModel.posts.isEmpty {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(viewModel.posts) { post in
                                NavigationLink(value: post) {
                                    PostCell(post: post)
                                }
                            }
                            .padding(.top)
                        }
                    }
                    .refreshable {
                        Task { await viewModel.fetchPosts() }
                    }
                    .overlay {
                        if viewModel.isLoading { ProgressView() }
                    }
                    .navigationTitle("SocialConnect")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                Task { await viewModel.fetchPosts() }
                            } label: {
                                Image(systemName: "arrow.counterclockwise")
                                    .foregroundColor(Color.theme.primaryText)
                            }
                        }
                    }
                    .padding([.top, .horizontal])
                } else {
                    ScrollView(showsIndicators: false) {
                        Text("No hay publicaciones recientes")
                    }
                    .refreshable {
                        Task { await viewModel.fetchPosts() }
                    }
                    .overlay {
                        if viewModel.isLoading { ProgressView() }
                    }
                    .navigationTitle("SocialConnect")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                Task { await viewModel.fetchPosts() }
                            } label: {
                                Image(systemName: "arrow.counterclockwise")
                                    .foregroundColor(Color.theme.primaryText)
                            }
                        }
                    }
                    .padding([.top, .horizontal])
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
