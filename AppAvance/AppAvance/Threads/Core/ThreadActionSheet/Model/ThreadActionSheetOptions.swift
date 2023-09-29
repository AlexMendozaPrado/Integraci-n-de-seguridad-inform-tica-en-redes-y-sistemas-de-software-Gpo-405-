// File.swift
// Threads
//

import Foundation

// **Línea 2:** Declara un enum llamado `ThreadActionSheetOptions`. Este enum representará las diferentes opciones que se pueden presentar en un menú contextual para un hilo.

enum ThreadActionSheetOptions {

// **Línea 3:** Define el caso `unfollow`. Este caso representa la opción de dejar de seguir al autor del hilo.

case unfollow

// **Línea 4:** Define el caso `mute`. Este caso representa la opción de silenciar las notificaciones del hilo.

case mute

// **Línea 5:** Define el caso `hide`. Este caso representa la opción de ocultar el hilo de la lista de hilos.

case hide

// **Línea 6:** Define el caso `report`. Este caso representa la opción de reportar el hilo.

case report

// **Línea 7:** Define el caso `block`. Este caso representa la opción de bloquear al autor del hilo.

case block

// **Línea 9:** Define la propiedad `title`. Esta propiedad define el título de la opción del menú contextual.

var title: String {

// **Línea 10:** Devuelve el título correspondiente al caso del enum.

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
