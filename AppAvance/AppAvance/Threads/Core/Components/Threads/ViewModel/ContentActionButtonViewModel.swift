// Importación necesaria
import Foundation

// Clase ViewModel para los botones de acción en el contenido (hilos o respuestas)
@MainActor
class ContentActionButtonViewModel: ObservableObject {
    @Published var thread: Thread? // El hilo asociado a esta vista
    @Published var reply: ThreadReply? // La respuesta asociada a esta vista (si es una respuesta)
    
    // Inicializador que toma un tipo de configuración (hilo o respuesta) y configura el ViewModel en consecuencia
    init(contentType: ThreadViewConfig) {
        switch contentType {
        case .thread(let thread):
            self.thread = thread
            Task { try await checkIfUserLikedThread() }
            
        case .reply(let reply):
            self.reply = reply
        }
    }
    
    // Función para marcar un hilo como "me gusta"
    func likeThread() async throws {
        guard let thread = thread else { return }
        
        try await ThreadService.likeThread(thread) // Llama al servicio para marcar el hilo como "me gusta"
        self.thread?.didLike = true // Actualiza el estado del hilo para reflejar que el usuario le dio "me gusta"
        self.thread?.likes += 1 // Incrementa el contador de "me gusta" en el hilo
    }
    
    // Función para desmarcar un hilo como "me gusta"
    func unlikeThread() async throws {
        guard let thread = thread else { return }

        try await ThreadService.unlikeThread(thread) // Llama al servicio para desmarcar el hilo como "me gusta"
        self.thread?.didLike = false // Actualiza el estado del hilo para reflejar que el usuario retiró su "me gusta"
        self.thread?.likes -= 1 // Reduce el contador de "me gusta" en el hilo
    }
    
    // Función para verificar si el usuario dio "me gusta" a un hilo
    func checkIfUserLikedThread() async throws {
        guard let thread = thread else { return }

        let didLike = try await ThreadService.checkIfUserLikedThread(thread) // Llama al servicio para verificar si el usuario dio "me gusta" al hilo
        if didLike {
            self.thread?.didLike = true // Actualiza el estado del hilo si el usuario ya dio "me gusta"
        }
    }
}
