// ActivityRowView.swift
// Threads
//
//

import SwiftUI

struct ActivityRowView: View {
    // MARK: - Properties

    let model: ActivityModel // This property stores the activity model that is being displayed.

    // MARK: - Computed Properties

    private var activityMessage: String { // This computed property returns the message for the activity.
        switch model.type {
        case .like:
            return model.thread?.caption ?? ""
        case .follow:
            return "Te sigue"
        case .reply:
            return "Ha dado respuesta a uno de tus hilos "
        }
    }

    private var isFollowed: Bool { // This computed property returns whether or not the user is following the user who performed the activity.
        return model.user?.isFollowed ?? false
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) { // This stack view displays the activity information.
            HStack(spacing: 16) { // This stack view displays the user's profile image and username.
                NavigationLink(value: model.user) { // This navigation link allows the user to navigate to the user's profile view.
                    ZStack(alignment: .bottomTrailing) { // This Z stack displays the user's profile image and an activity badge.
                        CircularProfileImageView(user: model.user, size: .medium) // This view displays the user's profile image.
                        ActivityBadgeView(type: model.type) // This view displays an activity badge.
                            .offset(x: 8, y: 4) // This offset positions the activity badge in the bottom right corner of the user's profile image.
                    }
                }

                VStack(alignment: .leading, spacing: 4) { // This stack view displays the user's username and the timestamp of the activity.
                    HStack(spacing: 4) { // This stack view displays the user's username and the timestamp of the activity.
                        Text(model.user?.username ?? "") // This text displays the user's username.
                            .bold()
                            .foregroundColor(Color.theme.primaryText)

                        Text(model.timestamp.timestampString()) // This text displays the timestamp of the activity.
                            .foregroundColor(.gray)
                    }

                    Text(activityMessage) // This text displays the message for the activity.
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                .font(.footnote)

                Spacer()

                if model.type == .follow { // This button is only displayed if the activity type is follow.
                    Button {
                        // TODO: Implement follow/unfollow logic.
                    } label: {
                        Text(isFollowed ? "Following" : "Follow")
                            .foregroundStyle(isFollowed ? Color(.systemGray4) : Color.theme.primaryText)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 100, height: 32)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)

            Divider() // This divider separates the activity from the next activity in the list.
                .padding(.leading, 80)
        }
    }
}

struct ActivityRowView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRowView(model: dev.activityModel)
    }
}
