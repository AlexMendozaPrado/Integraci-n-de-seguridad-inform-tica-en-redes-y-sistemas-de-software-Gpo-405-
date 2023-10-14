import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    @Published var username = ""
    @Published var isAuthenticating = true
    @Published var showAlert: Bool = false
    
    func createUser() {
        
    }
}
