// File.swift
// Threads
//

import Foundation

enum ThreadActionSheetOptions {
case unfollow
case mute
case hide
case report
case block

var title: String {
    switch self {
    case .unfollow:
    return "Dejar de Seguir"
    case .mute:
    return "Silenciar"
    case .hide:
    return "Esconder"
    case .report:
    return "Reportar"
    case .block:
    return "Bloquear"
    }
}
}
