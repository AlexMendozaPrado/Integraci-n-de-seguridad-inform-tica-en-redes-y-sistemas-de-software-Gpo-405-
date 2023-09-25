// ActivityFilterViewModel.swift
// Threads
//
//

import Foundation

enum ActivityFilterViewModel: Int, CaseIterable, Identifiable, Codable {
    // MARK: - Cases

    case all
    case replies

    // MARK: - Computed Properties

    var title: String { // This computed property returns the title of the filter.
        switch self {
        case .all: return "Todos"
        case .replies: return "Respuestas"
        }
    }

    var id: Int { // This computed property returns the identifier of the filter.
        return self.rawValue
    }
}
