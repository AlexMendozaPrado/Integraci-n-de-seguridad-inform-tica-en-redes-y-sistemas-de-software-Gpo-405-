// ActivityBadgeView.swift
// Threads
//
// This struct displays a badge that indicates the type of activity. The badge can be either a like, follow, or reply.

import SwiftUI

struct ActivityBadgeView: View {
    // MARK: - Properties

    let type: ActivityType // This property stores the type of activity that the badge represents.

    // MARK: - Computed Properties

    private var badgeColor: Color { // This computed property returns the color of the badge.
        switch type {
        case .like: return Color.theme.pink
        case .follow: return Color.theme.purple
        case .reply: return Color(.systemBlue)
        }
    }

    private var badgeImageName: String { // This computed property returns the image name of the badge.
        switch type {
        case .like: return "heart.fill"
        case .follow: return "person.fill"
        case .reply: return "arrowshape.turn.up.backward.fill"
        }
    }

    // MARK: - Body

    var body: some View {
        // This Z stack displays the badge background and the badge image.
        ZStack {
            // This circle represents the badge background.
            Circle()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.theme.primaryBackground)

            // This Z stack displays the badge image and a white overlay.
            ZStack {
                // This circle represents the badge image background.
                Circle()
                    .fill(badgeColor)
                    .frame(width: 18, height: 18)

                // This image represents the badge image.
                Image(systemName: badgeImageName)
                    .font(.caption2)
                    .foregroundColor(.white)
            }
        }
    }
}

struct ActivityBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityBadgeView(type: .follow)
    }
}
