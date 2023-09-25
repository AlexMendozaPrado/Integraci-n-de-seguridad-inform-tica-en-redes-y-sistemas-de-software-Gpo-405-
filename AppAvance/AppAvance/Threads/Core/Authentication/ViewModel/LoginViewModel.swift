// Importaciones necesarias
import FirebaseAuth

// Definición de la clase LoginViewModel
class LoginViewModel: ObservableObject {
    // Propiedades publicadas para almacenar datos relacionados con la autenticación
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticating = false // Indica si se está realizando una autenticación
    @Published var showAlert = false // Indica si se debe mostrar una alerta
    @Published var authError: AuthError? // Almacena información sobre el error de autenticación
    
    // Función de inicio de sesión asincrónico
    @MainActor
    func login() async throws {
        isAuthenticating = true // Se inicia la autenticación
        
        do {
            // Intenta realizar el inicio de sesión utilizando el servicio de autenticación compartido
            try await AuthService.shared.login(withEmail: email, password: password)
            isAuthenticating = false // Se completa la autenticación con éxito y se desactiva la bandera de autenticación
        } catch {
            // Si se produce un error durante el inicio de sesión, se captura y maneja
            let authError = AuthErrorCode.Code(rawValue: (error as NSError).code)
            self.showAlert = true // Se muestra una alerta
            isAuthenticating = false // Se desactiva la bandera de autenticación
            self.authError = AuthError(authErrorCode: authError ?? .userNotFound) // Se almacena información sobre el error de autenticación
        }
    }
}
