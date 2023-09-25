// ActivityModel.swift
// Threads
//
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

// MARK: - ActivityModel

struct ActivityModel: Identifiable, Codable, Hashable {
    // MARK: - Properties

    /// El identificador único de la actividad.
    @DocumentID private var activityModelId: String?

    /// El tipo de actividad. Esto puede ser `newThread`, `newComment` o `newFollower`.
    let type: ActivityType

    /// El identificador del usuario que realizó la actividad.
    let senderUid: String

    /// La fecha y hora en que se realizó la actividad.
    let timestamp: Timestamp

    /// El identificador del hilo al que está asociada la actividad.
    var threadId: String?

    /// El usuario que realizó la actividad.
    var user: User?

    /// El hilo al que está asociada la actividad.
    var thread: Thread?

    /// Un valor booleano que indica si el usuario actual está siguiendo al usuario que realizó la actividad.
    var isFollowed: Bool?

    // MARK: - Computed Properties

    /// El identificador único de la actividad.
    var id: String {
        return activityModelId ?? NSUUID().uuidString
    }
}
