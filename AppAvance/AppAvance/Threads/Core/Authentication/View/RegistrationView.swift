// Importaciones necesarias
import SwiftUI

// Definición de la vista RegistrationView
struct RegistrationView: View {
    // Se crea un objeto de vista modelo para la gestión de datos relacionados con el registro
    @StateObject var viewModel = RegistrationViewModel()
    // Se obtiene el entorno de cierre para permitir el cierre de la vista
    @Environment(\.dismiss) var dismiss
    
    // Cuerpo de la vista
    var body: some View {
        VStack {
            Spacer()
            
            // Se muestra el logo de la aplicación
            Image("threads-app-icon")
                .renderingMode(.template)
                .resizable()
                .colorMultiply(Color.theme.primaryText)
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            // Se crean campos de texto para el ingreso de información de registro
            VStack {
                TextField("Enter your email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(ThreadsTextFieldModifier())
                
                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Enter your full name", text: $viewModel.fullname)
                    .autocapitalization(.none)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Enter your username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(ThreadsTextFieldModifier())
            }
            
            // Botón para enviar la información de registro
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text(viewModel.isAuthenticating ? "" : "Sign up")
                    .foregroundColor(Color.theme.primaryBackground)
                    .modifier(ThreadsButtonModifier())
                    .overlay {
                        if viewModel.isAuthenticating {
                            ProgressView()
                                .tint(Color.theme.primaryBackground)
                        }
                    }
                    
            }
            .disabled(viewModel.isAuthenticating || !formIsValid) // Se desactiva el botón si no se cumple la validación del formulario
            .opacity(formIsValid ? 1 : 0.7)
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            // Botón para redirigir al usuario a la pantalla de inicio de sesión
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
                .foregroundColor(Color.theme.primaryText)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
        .alert(isPresented: $viewModel.showAlert) {
            // Se muestra una alerta en caso de error de autenticación
            Alert(title: Text("Error"),
                  message: Text(viewModel.authError?.description ?? ""))
        }
    }
}

// MARK: - Validación del formulario

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        // La validación del formulario verifica que los campos no estén vacíos y que el campo de correo electrónico contenga un "@" y que la contraseña sea lo suficientemente larga.
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && !viewModel.fullname.isEmpty
        && viewModel.password.count > 5
    }
}

// Vista previa de RegistrationView
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
