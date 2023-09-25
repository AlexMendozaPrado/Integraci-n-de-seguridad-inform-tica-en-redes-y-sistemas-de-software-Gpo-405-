// ActivityService.swift
// Threads
//
//

import Firebase
import FirebaseFirestoreSwift

struct ActivityService {
    // MARK: - Public Methods

    static func fetchUserActivity() async throws -> [ActivityModel] {
        // Gets the current user's UID.
        guard let uid = Auth.auth().currentUser?.uid else { return [] }

        // Fetches the list of notifications from Firestore.
        let snapshot = try await FirestoreConstants
            .ActivityCollection
            .document(uid)
            .collection("user-notifications")
            .order(by: "timestamp", descending: true)
            .getDocuments()

        // Converts the snapshot into a list of ActivityModel objects.
        return snapshot.documents.compactMap({ try? $0.data(as: ActivityModel.self) })
    }

    static func uploadNotification(toUid uid: String, type: ActivityType, threadId: String? = nil) {
        // Gets the current user's UID.
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        // Prevents the user from uploading a notification to themselves.
        guard uid != currentUid else { return }

        // Creates a new ActivityModel object.
        let model = ActivityModel(
            type: type,
            senderUid: currentUid,
            timestamp: Timestamp(),
            threadId: threadId
        )

        // Encodes the ActivityModel object into JSON data.
        guard let data = try? Firestore.Encoder().encode(model) else { return }

        // Saves the notification to Firestore.
        FirestoreConstants.ActivityCollection.document(uid).collection("user-notifications").addDocument(data: data)
    }

    static func deleteNotification(toUid uid: String, type: ActivityType, threadId: String? = nil) async throws {
        // Gets the current user's UID.
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        // Fetches the notification from Firestore.
        let snapshot = try await FirestoreConstants
            .ActivityCollection
            .document(uid)
            .collection("user-notifications")
            .whereField("uid", isEqualTo: currentUid)
            .getDocuments()

        // Deletes the notification from Firestore.
        for document in snapshot.documents {
            let notification = try? document.data(as: ActivityModel.self)
            guard notification?.type == type else { return }

            if threadId != nil {
                guard threadId == notification?.threadId else { return }
            }

            try await document.reference.delete()
        }
    }
}
