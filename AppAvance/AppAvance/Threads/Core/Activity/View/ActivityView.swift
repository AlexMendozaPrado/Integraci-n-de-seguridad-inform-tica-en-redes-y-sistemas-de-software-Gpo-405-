// ActivityView.swift
// Threads
//
//

import SwiftUI

// MARK: - ActivityView

struct ActivityView: View {
    // MARK: - State

    @StateObject var viewModel = ActivityViewModel() // This state object manages the view state, such as the selected filter and the list of activities to be displayed.

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ActivityFilterView(selectedFilter: $viewModel.selectedFilter) // This view allows the user to select a filter for the list of activities.
                        .padding(.vertical) // This adds top and bottom padding to the filter view.

                    LazyVStack(spacing: 16) { // This view displays the list of activities.
                        ForEach(viewModel.notifications) { activityModel in
                            if activityModel.type != .follow {
                                NavigationLink(value: activityModel) { // This navigation link allows the user to navigate to the details view of the activity.
                                    ActivityRowView(model: activityModel) // This view displays a row for the activity in the list.
                                }
                            } else {
                                NavigationLink(value: activityModel.user) { // This navigation link allows the user to navigate to the profile view of the user who performed the activity.
                                    ActivityRowView(model: activityModel) // This view displays a row for the activity in the list.
                                }
                            }
                        }
                    }
                }
            }
            .overlay {
                if viewModel.isLoading { // This overlay displays a progress view while the list of activities is being loaded.
                    ProgressView()
                }
            }
            .navigationTitle("Favoritos") // This sets the navigation title of the view.
            .navigationDestination(for: ActivityModel.self, destination: { model in // This navigation destination specifies how to navigate to the details view of an activity.
                if let thread = model.thread {
                    ThreadDetailsView(thread: thread)
                }
            })
            .navigationDestination(for: User.self, destination: { user in // This navigation destination specifies how to navigate to the profile view of a user.
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
