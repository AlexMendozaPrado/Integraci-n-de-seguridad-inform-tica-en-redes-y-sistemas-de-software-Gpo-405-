// ActivityViewModel.swift
// Threads
//
//

import SwiftUI

@MainActor
class ActivityViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var notifications = [ActivityModel]() // This published property stores the list of notifications.
    @Published var isLoading = false // This published property stores the loading state of the view model.
    @Published var selectedFilter: ActivityFilterViewModel = .all { // This published property stores the selected filter.
        didSet {
            // Whenever the selected filter changes, the list of notifications is updated to reflect the selected filter.
            switch selectedFilter {
            case .all:
                self.notifications = temp
            case .replies:
                temp = notifications
                self.notifications = notifications.filter({ $0.type == .reply })
            }
        }
    }

    // MARK: - Private Properties

    private var temp = [ActivityModel]() // This private property stores the temporary list of notifications. This property is used to store the original list of notifications before the selected filter is changed.

    // MARK: - Initialization

    init() {
        // When the view model is initialized, the list of notifications is fetched from the backend.
        Task { try await updateNotifications() }
    }

    // MARK: - Private Methods

    private func fetchNotificationData() async throws {
        // Sets the loading state to true.
        self.isLoading = true

        // Fetches the list of notifications from the backend.
        self.notifications = try await ActivityService.fetchUserActivity()

        // Sets the loading state to false.
        self.isLoading = false
    }

    private func updateNotifications() async throws {
        // Fetches the notification data from the backend.
        try await fetchNotificationData()

        // Creates a throwing task group that will update the metadata for each notification.
        await withThrowingTaskGroup(of: Void.self, body: { group in
            for notification in notifications {
                // Adds a task to the task group that will update the metadata for the notification.
                group.addTask { try await self.updateNotificationMetadata(notification: notification) }
            }
        })
    }

    private func updateNotificationMetadata(notification: ActivityModel) async throws {
        // Finds the index of the notification in the list of notifications.
        guard let indexOfNotification = notifications.firstIndex(where: { $0.id == notification.id }) else { return }

        // Fetches the user associated with the notification.
        async let notificationUser = try await UserService.fetchUser(withUid: notification.senderUid)
        var user = try await notificationUser

        // If the notification type is follow, the follow status of the user is also fetched.
        if notification.type == .follow {
            async let isFollowed = await UserService.checkIfUserIsFollowedWithUid(notification.senderUid)
            user.isFollowed = await isFollowed
        }

        // Updates the notification with the updated user information.
        self.notifications[indexOfNotification].user = user

        // If the notification is associated with a thread, the thread is also fetched.
        if let threadId = notification.threadId {
            async let threadSnapshot = await FirestoreConstants.ThreadsCollection.document(threadId).getDocument()
            self.notifications[indexOfNotification].thread = try? await threadSnapshot.data(as: Thread.self)
        }
    }
}
