// Importaciones necesarias
import FirebaseAuth

// Definición de la clase RegistrationViewModel
class RegistrationViewModel: ObservableObject {
    // Propiedades publicadas para almacenar datos relacionados con la creación de usuarios
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    @Published var username = ""
    @Published var isAuthenticating = false // Indica si se está realizando la autenticación
    @Published var showAlert = false // Indica si se debe mostrar una alerta
    @Published var authError: AuthError? // Almacena información sobre el error de autenticación
    
    // Función de creación de usuario asincrónica
    @MainActor
    func createUser() async throws {
        isAuthenticating = true // Se inicia la autenticación
        
        do {
            // Intenta crear un usuario utilizando el servicio de autenticación compartido
            try await AuthService.shared.createUser(
                withEmail: email,
                password: password,
                fullname: fullname,
                username: username
            )
            isAuthenticating = false // Se completa la creación de usuario con éxito y se desactiva la bandera de autenticación
        } catch {
            // Si se produce un error durante la creación de usuario, se captura y maneja
            let authErrorCode = AuthErrorCode.Code(rawValue: (error as NSError).code)
            showAlert = true // Se muestra una alerta
            isAuthenticating = false // Se desactiva la bandera de autenticación
            authError = AuthError(authErrorCode: authErrorCode ?? .userNotFound) // Se almacena información sobre el error de autenticación
        }
    }
}
