// ActivityType.swift
// Threads
//
//

import Foundation

// MARK: - ActivityType

enum ActivityType: Int, CaseIterable, Identifiable, Codable {
    // MARK: - Cases

    case like
    case reply
    case follow

    // MARK: - Computed Properties

    /// El identificador único del tipo de actividad.
    var id: Int { return self.rawValue }
}
