// ActivityView.swift
// Threads
//
//

import SwiftUI

struct ActivityView: View {
    @StateObject var viewModel = ActivityViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.organizations) { org in
                            NavigationLink(value: org.id) {
                                ActivityRowView(model: org)
                            }
                        }
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationTitle("Favoritos")
            .navigationDestination(for: ActivityModel.self, destination: { model in
                if let thread = model.thread {
                    ThreadDetailsView(thread: thread)
                }
            })
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
        }
    }
}

// MARK: - ActivityView_Previews

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
