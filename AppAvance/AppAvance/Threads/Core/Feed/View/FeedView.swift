//
//  FeedView.swift
//  Threads
//
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        if (!viewModel.posts.isEmpty) {
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(viewModel.posts) { post in
                            NavigationLink(value: post) {
                                PostCell(config: .post(post))
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
                .navigationDestination(for: User.self, destination: { user in
                    if user.isCurrentUser {
                        CurrentUserProfileView(didNavigate: true)
                    } else {
                        ProfileView(user: user)
                    }
                })
                .navigationDestination(for: Thread.self, destination: { thread in
                    ThreadDetailsView(thread: thread)
                })
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
        else {
            NavigationStack {
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

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
