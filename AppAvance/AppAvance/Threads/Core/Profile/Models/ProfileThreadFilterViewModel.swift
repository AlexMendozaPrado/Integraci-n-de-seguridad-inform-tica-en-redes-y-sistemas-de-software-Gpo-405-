//
//  ProfileThreadFilterViewModel.swift
//  Threads
//
//

import Foundation

enum ProfileThreadFilterViewModel: Int, CaseIterable, Identifiable {
    case threads
    case replies
    
    var title: String {
        switch self {
        case .threads: return "Publicaciones"
        case .replies: return "Respuestas"
        }
    }
    
    var id: Int { return self.rawValue }
}
