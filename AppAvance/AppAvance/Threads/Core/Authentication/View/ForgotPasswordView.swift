// Importaciones necesarias
import SwiftUI

// Definición de la vista ForgotPasswordView
struct ForgotPasswordView: View {
    // Se crea un objeto de vista modelo para la gestión de datos relacionados con el restablecimiento de contraseña
    @StateObject var viewModel = ForgotPasswordViewModel()
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
            
            // Se crea un campo de texto para que el usuario ingrese su dirección de correo electrónico
            VStack {
                TextField("Enter your email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(ThreadsTextFieldModifier())
            }
            
            // Botón para enviar una solicitud de restablecimiento de contraseña
            Button {
                Task { try await viewModel.sendPasswordResetEmail() }
            } label: {
                Text("Reset Password")
                    .foregroundColor(Color.theme.primaryBackground)
                    .modifier(ThreadsButtonModifier())
            }
            .disabled(!formIsValid) // Se desactiva el botón si no se cumple la validación del formulario
            .opacity(formIsValid ? 1 : 0.7)
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            // Botón para regresar a la pantalla de inicio de sesión
            Button {
                dismiss()
            } label: {
                Text("Return to login")
                    .foregroundColor(Color.theme.primaryText)
                    .font(.footnote)
            }
            .padding(.vertical, 16)
        }
        // Alerta que se presenta cuando se ha enviado un correo electrónico de restablecimiento de contraseña
        .alert(isPresented: $viewModel.didSendEmail) {
            Alert(
                title: Text("Email sent"),
                message: Text("An email has been sent to \(viewModel.email) to reset your password"),
                dismissButton: .default(Text("Ok"), action: {
                    dismiss()
                })
            )
        }
    }
}

// MARK: - Validación del formulario

extension ForgotPasswordView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        // La validación del formulario verifica que el campo de correo electrónico no esté vacío y contenga un "@"
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
    }
}

// Vista previa de ForgotPasswordView
struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
