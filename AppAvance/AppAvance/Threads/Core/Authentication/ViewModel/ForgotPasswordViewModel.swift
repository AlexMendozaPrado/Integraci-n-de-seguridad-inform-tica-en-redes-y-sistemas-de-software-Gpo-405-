// Importación necesaria
import Foundation

// Definición de la clase ForgotPasswordViewModel
@MainActor
class ForgotPasswordViewModel: ObservableObject {
    // Propiedades publicadas para almacenar datos relacionados con el restablecimiento de contraseña
    @Published var email = "" // Almacena la dirección de correo electrónico proporcionada por el usuario
    @Published var didSendEmail = false // Indica si se ha enviado el correo electrónico de restablecimiento de contraseña
    
    // Función para enviar un correo electrónico de restablecimiento de contraseña de forma asincrónica
    func sendPasswordResetEmail() async throws {
        // Intenta enviar un correo electrónico de restablecimiento de contraseña utilizando el servicio de autenticación compartido
        try await AuthService.shared.sendPasswordResetEmail(toEmail: email)
        didSendEmail = true // Marca que se ha enviado el correo electrónico con éxito
    }
}
